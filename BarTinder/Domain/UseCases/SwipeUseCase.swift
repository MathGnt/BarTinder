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
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func executeGetCocktails() throws(NetworkErrors) {
        do {
            let cocktails = try repo.getAllCocktails()
            dump("first is \(cocktails.first?.ingredientsMeasures.count)")
            for cocktail in cocktails {
                repo.callContextInsert(cocktail)
                dump("cocktails are \(cocktail.ingredientsMeasures)")
                for ingredientMeasures in cocktail.ingredientsMeasures {
                    dump("ingredients are \(ingredientMeasures.ingredient)")
                }
            }
        
        } catch {
            print("Failed to get all cocktails from API")
            throw .failedToGetCocktails
        }
    }
    
    func executeUpdatePossibleCocktails(selectedIngredients: Set<String>) {
        let cocktails = repo.callGetContextContent()
        for cocktail in cocktails {
            let ingredientNames = Set(cocktail.ingredientsMeasures.map { $0.ingredient })
            if selectedIngredients.isSuperset(of: ingredientNames) {
                cocktail.isPossible = true
            }
        }
        repo.callContextSave()
    }
}
