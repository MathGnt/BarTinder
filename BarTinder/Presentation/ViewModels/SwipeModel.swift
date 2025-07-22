//
//  SwipeModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import Foundation
import Observation
import SwiftUI
import SwiftData

@Observable
final class SwipeModel {
    let useCase: SwipeUseCase
    
    private(set) var ingredients: [CardIngredient] = CardIngredient.ingredientCards
    
    /// Animation
    private var cardOffsets: [String: CGFloat] = [:]
    private var cardRotations: [String: Double] = [:]
    private var threshold: CGFloat {
        (UIScreen.main.bounds.width / 2) * 0.8
    }
    
    var fetchingError = false
    
    init(useCase: SwipeUseCase) {
        self.useCase = useCase
    }
    
    
    func setOffset(for card: CardIngredient, value: CGFloat) {
        cardOffsets[card.id] = value
    }
    
    func getOffset(for card: CardIngredient) -> CGFloat {
        return cardOffsets[card.id] ?? 0
    }
    
    func setRotation(for card: CardIngredient, value: Double) {
        cardRotations[card.id] = value
    }
    
    func getRotation(for card: CardIngredient) -> Double {
        return cardRotations[card.id] ?? 0
    }
    
    func onEndedGesture(_ value: _ChangedGesture<DragGesture>.Value, _ card: CardIngredient) {
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
    
    
    func onChangedGesture(card: CardIngredient, translation: CGFloat) {
        setOffset(for: card, value: translation)
        setRotation(for: card, value: translation / 25)
    }
    
    func getCocktails() {
        do {
            try useCase.executeGetCocktails()
        } catch .failedToGetCocktails {
            fetchingError = true
        } catch {
            print("unknown error: \(error)")
        }
    }
    
    func addIngredient(_ card: CardIngredient) {
        useCase.executeAddIngredient(card)
    }
    
    func removeIngredient(_ card: CardIngredient) {
        guard let index = ingredients.firstIndex(where: { $0.id == card.id }) else { return }
        ingredients.remove(at: index)
        
        cardOffsets.removeValue(forKey: card.id)
        cardRotations.removeValue(forKey: card.id)
    }
    
    func removeSelectedIngredients() {
        useCase.executeRemoveAllIngredients()
    }
    
    func updatePossibleCocktails() {
        useCase.executeUpdatePossibleCocktails()
    }
    
    func recenter(card: CardIngredient) {
        setOffset(for: card, value: 0)
        setRotation(for: card, value: 0)
    }
    
    func swipeLeft(card: CardIngredient) {
        withAnimation {
            setOffset(for: card, value: -500)
            setRotation(for: card, value: -12)
        }
        
        Task {
            try? await Task.sleep(for: .seconds(0.3))
            removeIngredient(card)
        }
    }
    
    func swipeRight(card: CardIngredient) {
        withAnimation {
            setOffset(for: card, value: 500)
            setRotation(for: card, value: 12)
        }
        
        Task {
            try? await Task.sleep(for: .seconds(0.3))
            removeIngredient(card)
            addIngredient(card)
        }
    }
    
    func triggerSwipeLeft(card: CardIngredient) {
        swipeLeft(card: card)
    }
    
    func triggerSwipeRight(card: CardIngredient) {
        swipeRight(card: card)
    }
}

