/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A use case that checks and creates the cocktail the user made.
*/

import Foundation

struct CreationUseCase {
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func executeCocktailChecking(_ cocktail: Cocktail) throws(CreationErrors) {
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
