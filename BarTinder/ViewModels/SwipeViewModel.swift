//
//  SwipeViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import Foundation
import Observation
import SwiftUI

@Observable
class SwipeViewModel {
    
    let repo: CocktailRepo
    var cocktails: [Cocktail] = []
    var ingredients: [IngredientCard] = []
    var possibleCocktails: [Cocktail] = []
    var selectedCategory: Category = .possibleCocktails
    var finishSwiping = false
    
    private var cardOffsets: [String: CGFloat] = [:]
    private var cardRotations: [String: Double] = [:]
    
    var sortedCocktails: [Cocktail] {
        switch selectedCategory {
        case .possibleCocktails:
            return possibleCocktails
        case .gin:
            return possibleCocktails.filter { $0.ingredients.contains("gin") }
        case .vodka:
            return possibleCocktails.filter { $0.ingredients.contains("vodka") }
        case .vermouth:
            return possibleCocktails.filter { $0.ingredients.contains("vermouth") }
        case .whisky:
            return possibleCocktails.filter { $0.ingredients.contains("whisky") || $0.ingredients.contains("rye whiskey") }
        case .shortDrink:
            return possibleCocktails.filter { $0.style == "short" }
        case .longDrink:
            return possibleCocktails.filter { $0.style == "long" }
        }
    }
    
    var selectedIngredients: Set<String> = []
    
    var threshold: CGFloat {
        (UIScreen.main.bounds.width / 2) * 0.8
    }
    
    init(repo: CocktailRepo) {
        self.repo = repo
    }
    
    
    func getOffset(for card: IngredientCard) -> CGFloat {
        return cardOffsets[card.id] ?? 0
    }
    
    func setOffset(for card: IngredientCard, value: CGFloat) {
        cardOffsets[card.id] = value
    }
    
    func getRotation(for card: IngredientCard) -> Double {
        return cardRotations[card.id] ?? 0
    }
    
    func setRotation(for card: IngredientCard, value: Double) {
        cardRotations[card.id] = value
    }
    
    func onChangedGesture(card: IngredientCard, translation: CGFloat) {
        setOffset(for: card, value: translation)
        setRotation(for: card, value: translation / 25)
    }
    
    func getCocktails() {
        addIngredients()
        do {
            let cocktails = try repo.getAllCocktails()
            self.cocktails = cocktails
            updatePossibleCocktails()
        } catch {
            print(VMErrors.couldntFetchCocktails.localizedDescription as Any)
        }
    }
    
    func addIngredients() {
        self.ingredients = IngredientCard.ingredientCards
    }
    
    func addIngredient(_ card: IngredientCard) {
        selectedIngredients.insert(card.name)
        if let otherName = card.otherName {
            selectedIngredients.insert(otherName)
        }
        print("added \(card.name) to the selection SET")
        updatePossibleCocktails()
    }
    
    func updatePossibleCocktails() {
        possibleCocktails.removeAll()
        
        if selectedIngredients.isEmpty {
            possibleCocktails = cocktails
            return
        }
        
        for cocktail in cocktails {
            let ingredientsSet = Set(cocktail.ingredients)
            if selectedIngredients.isSuperset(of: ingredientsSet) {
                possibleCocktails.append(cocktail)
            }
        }
    }
    
    func removeIngredient(_ card: IngredientCard) {
        guard let index = ingredients.firstIndex(where: { $0.id == card.id }) else { return }
        ingredients.remove(at: index)
        
        cardOffsets.removeValue(forKey: card.id)
        cardRotations.removeValue(forKey: card.id)
        
        print("removed \(card.name)")
    }
    
    func onEndedGesture(_ value: _ChangedGesture<DragGesture>.Value, _ card: IngredientCard) {
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
    
    func recenter(card: IngredientCard) {
        setOffset(for: card, value: 0)
        setRotation(for: card, value: 0)
    }
    
    func swipeLeft(card: IngredientCard) {
        withAnimation {
            setOffset(for: card, value: -500)
            setRotation(for: card, value: -12)
        }
        
        Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            removeIngredient(card)
        }
    }
    
    func swipeRight(card: IngredientCard) {
        withAnimation {
            setOffset(for: card, value: 500)
            setRotation(for: card, value: 12)
        }
        
        Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            removeIngredient(card)
            addIngredient(card)
        }
    }
    
    // SwipeView Buttons (xmark + heart) - star will come later
    func triggerSwipeLeft(card: IngredientCard) {
        swipeLeft(card: card)
    }
    
    func triggerSwipeRight(card: IngredientCard) {
        swipeRight(card: card)
    }
    
    func getIngredientsMeasures(cocktail: Cocktail) -> [(String, String)] {
        let allIngredients = cocktail.ingredients
        let measures = cocktail.measures
        
        let ingredientsMeasures = Array(zip(allIngredients, measures))
        
        return ingredientsMeasures.isEmpty ? [("Unknown", "Unknown")] : ingredientsMeasures
    }
}
