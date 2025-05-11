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
class SwipeViewModel {
    
    let repo: CocktailRepo
    var ingredients: [IngredientCard] = []

    private var cardOffsets: [String: CGFloat] = [:]
    private var cardRotations: [String: Double] = [:]
    
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
    
    func getCocktails(context: ModelContext) {
        addIngredients()
        do {
            let cocktails = try repo.getAllCocktails()
            print("cocktails fetched are \(cocktails)")
            for cocktail in cocktails {
                context.insert(cocktail)
            }
            
        } catch {
            print(VMErrors.couldntFetchCocktails.localizedDescription as Any)
        }
    }
    
    func addIngredients() {
        self.ingredients = IngredientCard.ingredientCards
    }
    
    func addIngredient(_ card: IngredientCard, context: ModelContext) {
        selectedIngredients.insert(card.name)
        if let otherName = card.otherName {
            selectedIngredients.insert(otherName)
        }
        print("added \(card.name) to the selection SET")
        updatePossibleCocktails(context: context)
    }
    
    func removeIngredient(_ card: IngredientCard) {
        guard let index = ingredients.firstIndex(where: { $0.id == card.id }) else { return }
        ingredients.remove(at: index)
        
        cardOffsets.removeValue(forKey: card.id)
        cardRotations.removeValue(forKey: card.id)
        
        print("removed \(card.name)")
    }
    
    func updatePossibleCocktails(context: ModelContext) {
        print("Updating possible cocktails with \(selectedIngredients.count) ingredients")
        let cocktails = getContextContent(context: context)
        for cocktail in cocktails {
            let ingredientNames = Set(cocktail.ingredientsMeasures.map { $0.ingredient })
            if selectedIngredients.isSuperset(of: ingredientNames) {
                print("found a cocktail!! \(cocktail)")
                cocktail.isPossible = true
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving cocktails: \(error)")
        }
    }
    
    func getContextContent(context: ModelContext) -> [Cocktail] {
        do {
            return try context.fetch(FetchDescriptor<Cocktail>())
        } catch {
            print("Error fetching cocktails: \(error)")
            return []
        }
    }
    
    func onEndedGesture(_ value: _ChangedGesture<DragGesture>.Value, _ card: IngredientCard, context: ModelContext) {
        let width = value.translation.width
        
        if abs(width) <= abs(threshold) {
            recenter(card: card)
            return
        }
        
        if width >= threshold {
            swipeRight(card: card, context: context)
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
    
    func swipeRight(card: IngredientCard, context: ModelContext) {
        withAnimation {
            setOffset(for: card, value: 500)
            setRotation(for: card, value: 12)
        }
        
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 300_000_000)
            removeIngredient(card)
            addIngredient(card, context: context)
        }
    }
    
    func triggerSwipeLeft(card: IngredientCard) {
        swipeLeft(card: card)
    }
    
    func triggerSwipeRight(card: IngredientCard, context: ModelContext) {
        swipeRight(card: card, context: context)
    }
}

