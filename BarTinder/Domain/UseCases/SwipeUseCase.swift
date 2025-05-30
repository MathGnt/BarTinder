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
    
    func executeGetCocktails() {
        do {
            let cocktails = try repo.getAllCocktails()
            for cocktail in cocktails {
                repo.callContextInsert(cocktail)
            }
            repo.callContextSave()
        } catch {
            print(VMErrors.couldntFetchCocktails.localizedDescription)
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
