/*
See the LICENSE file for this project's licensing information.

Abstract:
A use case that manages selected ingredients made by the user.
*/

import Foundation
import SwiftData

final class IngredientUseCase {
    private(set) var selectedIngredients: Set<String> = []
    
    func executeAddIngredient(_ card: CardIngredient) {
        selectedIngredients.insert(card.name)
        card.otherName.forEach { selectedIngredients.insert($0) }
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
