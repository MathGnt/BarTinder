//
//  SwipeViewUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation
import SwiftData

class SwipeViewUseCase: Swipable {
    
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func getCocktails() {
        do {
            let cocktails = try repo.getAllCocktails()
            for cocktail in cocktails {
                repo.contextInsert(cocktail)
            }
            repo.contextSave()
        } catch {
            print(VMErrors.couldntFetchCocktails.localizedDescription)
        }
    }
    
    func updatePossibleCocktails(selectedIngredients: Set<String>) {
        let cocktails = repo.getContextContent()
        for cocktail in cocktails {
            let ingredientNames = Set(cocktail.ingredientsMeasures.map { $0.ingredient })
            if selectedIngredients.isSuperset(of: ingredientNames) {
                cocktail.isPossible = true
            }
        }
        repo.contextSave()
    }
}
