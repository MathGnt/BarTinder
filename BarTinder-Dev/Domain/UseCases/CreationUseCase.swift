/*
See the LICENSE file for this project's licensing information.

Abstract:
A use case that checks and creates the cocktail the user made.
*/

import Foundation

struct CreationUseCase {
    func executeCocktailChecking(_ cocktail: Cocktail) throws(CreationErrors) {
        guard !cocktail.ingredients.isEmpty,
              !firstInvalidField(cocktail)
        else { throw .emptyCocktailFields }
    }
    
    private func firstInvalidField(_ cocktail: Cocktail) -> Bool {
        if cocktail.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        if cocktail.cocktailDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
    
    func executeIngredientsChecking(_ ingredients: [Ingredient]) throws(CreationErrors) {
        for ingredient in ingredients {
            let isMeasureEmpty = ingredient.measure
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
            if isMeasureEmpty && ingredient.unit.needsMeasure {
                throw .emptyMeasuresFields
            }
        }
    }
}
