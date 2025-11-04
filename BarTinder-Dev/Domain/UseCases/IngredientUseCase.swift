/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A use case that manages selected ingredients made by the user.
*/

import Foundation
import SwiftData

final class IngredientUseCase {
    private var selectedIngredients: Set<String> = []
    
    func executeAddIngredient(_ card: CardIngredient) {
        selectedIngredients.insert(card.name)
        if let otherName = card.otherName {
            selectedIngredients.insert(otherName)
        }
    }
    
    func executeRemoveAllIngredients() {
        selectedIngredients.removeAll()
    }
    
    func executeUpdatePossibleCocktails(cocktails: [Cocktail]) {
        for cocktail in cocktails {
            let ingredientNames = Set(cocktail.ingredients.map(\.name))
            if selectedIngredients.isSuperset(of: ingredientNames) {
                cocktail.isPossible = true
            }
        }
    }
}

