//
//  SwipeUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation
import SwiftData

class SwipeUseCase {
    
    let repo: Servable
    
    private var selectedIngredients: Set<String> = []
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func executeGetCocktails() throws(NetworkErrors) {
        do {
            try repo.getAllCocktails()
            repo.callContextSave()
        } catch {
            print("Failed to get all cocktails from API")
            throw .failedToGetCocktails
        }
    }
    
    func executeAddIngredient(_ card: CardIngredient) {
        selectedIngredients.insert(card.name)
        if let otherName = card.otherName {
            selectedIngredients.insert(otherName)
        }
        executeUpdatePossibleCocktails()
    }
    
    func executeRemoveAllIngredients() {
        selectedIngredients.removeAll()
    }
    
    func executeUpdatePossibleCocktails() {
        let cocktails = repo.callGetContextContent()
        for cocktail in cocktails {
            let ingredientNames = Set(cocktail.ingredients.map { $0.name })
            if selectedIngredients.isSuperset(of: ingredientNames) {
                cocktail.isPossible = true
            }
        }
        repo.callContextSave()
    }
}
