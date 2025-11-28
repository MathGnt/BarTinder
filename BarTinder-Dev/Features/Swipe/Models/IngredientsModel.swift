/*
See the LICENSE file for this project's licensing information.

Abstract:
An observable model that manages ingredient selection and swipe interactions.
*/

import Foundation
import SwiftUI
import SwiftData


@Observable
final class IngredientsModel {
    private let useCase: IngredientUseCase

    private(set) var ingredients: [CardIngredient] = []

    init(useCase: IngredientUseCase = IngredientUseCase()) {
        self.useCase = useCase
        self.ingredients = CardIngredient.ingredientCards
    }

    func swipeLeft(card: CardIngredient) {
        removeIngredient(card)
    }

    func swipeRight(card: CardIngredient) {
        addIngredient(card)
        removeIngredient(card)
    }
    
    func addIngredient(_ card: CardIngredient) {
        useCase.executeAddIngredient(card)
    }
    
    func removeIngredient(_ card: CardIngredient) {
        print("removed \(card)")
        guard let index = ingredients.firstIndex(where: { $0.id == card.id }) else { return }
        ingredients.remove(at: index)
    }
    
    func updatePossibleCocktails(cocktails: [Cocktail]) {
        useCase.executeUpdatePossibleCocktails(cocktails: cocktails)
    }
}

