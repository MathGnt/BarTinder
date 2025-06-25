//
//  CreationUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation

class CreationUseCase {
    
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func createNewCocktail(_ cocktail: Cocktail) {
        repo.callContextInsert(cocktail)
        repo.callContextSave()
    }
    
    func executeCocktailChecking(_ cocktail: Cocktail) -> Bool {
        guard !cocktail.ingredients.isEmpty else {
            return false
        }
        if !textValid(cocktail.abv, cocktail.cocktailDescription, cocktail.name, cocktail.flavor) {
            return false
        }
        return true
    }
    
    private func textValid(_ strings: String...) -> Bool {
        return strings.allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
    func executeIngredientsChecking(_ ingredients: [Ingredient]) -> Bool {
         for ingredient in ingredients {
             guard !ingredient.measure.trimmingCharacters(in:
     .whitespacesAndNewlines).isEmpty else {
                 guard ingredient.unit == .topUp || ingredient.unit ==
     .toRinse else {
                     return false
                 }
                 continue
             }
         }
         return true
     }
}
