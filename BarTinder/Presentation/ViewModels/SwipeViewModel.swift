//
//  SwipeViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import Foundation
import Observation
import SwiftUI
import SwiftData

@Observable
@MainActor
final class SwipeViewModel {
    
    let useCase: SwipeUseCase
    private(set) var ingredients: [Ingredient] = []

    private var cardOffsets: [String: CGFloat] = [:]
    private var cardRotations: [String: Double] = [:]
    private var selectedIngredients: Set<String> = []
    private var threshold: CGFloat {
        (UIScreen.main.bounds.width / 2) * 0.8
    }
    
    init(useCase: SwipeUseCase) {
        self.useCase = useCase
    }
    
    func setOffset(for card: Ingredient, value: CGFloat) {
        cardOffsets[card.id] = value
    }
    
    func getOffset(for card: Ingredient) -> CGFloat {
        return cardOffsets[card.id] ?? 0
    }
    
    func setRotation(for card: Ingredient, value: Double) {
        cardRotations[card.id] = value
    }
    
    func getRotation(for card: Ingredient) -> Double {
        return cardRotations[card.id] ?? 0
    }
    
    func onEndedGesture(_ value: _ChangedGesture<DragGesture>.Value, _ card: Ingredient) {
        let width = value.translation.width
        
        if abs(width) <= abs(threshold) {
            recenter(card: card)
            return
        }
        
        if width >= threshold {
            swipeRight(card: card)
        } else {
            swipeLeft(card: card)
        }
    }
    
    
    func onChangedGesture(card: Ingredient, translation: CGFloat) {
        setOffset(for: card, value: translation)
        setRotation(for: card, value: translation / 25)
    }
    
    func getCocktails() {
        addIngredients()
        useCase.executeGetCocktails()
    }
    
    func addIngredients() {
        self.ingredients = Ingredient.ingredientCards
    }
    
    func addIngredient(_ card: Ingredient) {
        selectedIngredients.insert(card.name)
        if let otherName = card.otherName {
            selectedIngredients.insert(otherName)
        }
        print("added \(card.name) to the selection SET")
        updatePossibleCocktails()
    }
    
    func updatePossibleCocktails() {
        useCase.executeUpdatePossibleCocktails(selectedIngredients: selectedIngredients)
    }
    
    func removeIngredient(_ card: Ingredient) {
        guard let index = ingredients.firstIndex(where: { $0.id == card.id }) else { return }
        ingredients.remove(at: index)
        
        cardOffsets.removeValue(forKey: card.id)
        cardRotations.removeValue(forKey: card.id)
        
        print("removed \(card.name)")
    }
    
    func removeSelectedIngredients() {
        selectedIngredients.removeAll()
    }
    
    func recenter(card: Ingredient) {
        setOffset(for: card, value: 0)
        setRotation(for: card, value: 0)
    }
    
    func swipeLeft(card: Ingredient) {
        withAnimation {
            setOffset(for: card, value: -500)
            setRotation(for: card, value: -12)
        }
        
        Task {
            try? await Task.sleep(for: .seconds(0.3))
            removeIngredient(card)
        }
    }
    
    func swipeRight(card: Ingredient) {
        withAnimation {
            setOffset(for: card, value: 500)
            setRotation(for: card, value: 12)
        }
        
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(0.3))
            removeIngredient(card)
            addIngredient(card)
        }
    }
    
    func triggerSwipeLeft(card: Ingredient) {
        swipeLeft(card: card)
    }
    
    func triggerSwipeRight(card: Ingredient) {
        swipeRight(card: card)
    }
}

