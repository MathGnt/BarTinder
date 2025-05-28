//
//  UseCases.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation
import SwiftData

protocol Buildable {
    func makeIngredientMeasures(
        ingredients: [Ingredient],
        cocktailMeasure: [String: String],
        selectedUnit: [String: CocktailCreationViewModel.Units]
    ) throws -> [IngredientMeasure]
    func createNewCocktail(_ cocktail: Cocktail)
    func textValid(_ strings: String...) -> Bool
}

protocol Swipable {
    func executeGetCocktails()
    func executeUpdatePossibleCocktails(selectedIngredients: Set<String>)
}
