//
//  CreationUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation

final class CreationUseCase {
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func createNewCocktail(_ cocktail: Cocktail) {
        repo.callContextInsert(cocktail)
        repo.callContextSave()
    }
    
    func executeCocktailChecking(_ cocktail: Cocktail) throws(CreationErrors) {
        guard !cocktail.ingredients.isEmpty else {
            throw .emptyCocktailFields(.measure)
        }
        guard let invalidField = firstInvalidField(cocktail) else { return }
        throw .emptyCocktailFields(invalidField)
    }
    
    func firstInvalidField(_ cocktail: Cocktail) -> Focus? {
        if cocktail.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .name
        }
        if cocktail.cocktailDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .description
        }
        return nil
    }
    
    func executeIngredientsChecking(_ ingredients: [Ingredient]) throws(CreationErrors) {
         for ingredient in ingredients {
             guard !ingredient.measure.trimmingCharacters(in:
     .whitespacesAndNewlines).isEmpty else {
                 guard ingredient.unit == .topUp || ingredient.unit ==
     .toRinse else {
                     throw .emptyMeasuresFields
                 }
                 continue
             }
         }
     }
}
