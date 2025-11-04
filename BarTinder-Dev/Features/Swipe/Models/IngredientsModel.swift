/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An observable model that manages ingredient selection and swipe interactions.
*/

import Foundation
import Observation
import SwiftUI
import SwiftData


@Observable
final class IngredientsModel {
    let useCase: IngredientUseCase

    private(set) var ingredients: [CardIngredient] = []

    init(useCase: IngredientUseCase) {
        self.useCase = useCase
        self.ingredients = CardIngredient.ingredientCards
    }

    func swipeLeft(card: CardIngredient) async {
        await removeIngredient(card)
    }

    func swipeRight(card: CardIngredient) async {
        addIngredient(card)
        await removeIngredient(card)
    }
    
    
    func addIngredient(_ card: CardIngredient) {
        useCase.executeAddIngredient(card)
    }
    
    func removeIngredient(_ card: CardIngredient) async {
        guard let index = ingredients.firstIndex(where: { $0.id == card.id }) else { return }
        try? await Task.sleep(for: .seconds(0.3))
        ingredients.remove(at: index)
    }
    
    func removeSelectedIngredients() {
        useCase.executeRemoveAllIngredients()
    }
    
    func updatePossibleCocktails(cocktails: [Cocktail]) {
        useCase.executeUpdatePossibleCocktails(cocktails: cocktails)
    }
    
    enum Constants {
        static let swipeOutDistance: CGFloat = 500
        static let maxRotation: Double = 12
        static let gradientHeightOffset: CGFloat = 200
    }
}

