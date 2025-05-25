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
    ) -> [IngredientMeasure]
    func createNewCocktail(_ cocktail: Cocktail)
}

protocol Swipable {
    func getCocktails()
    func updatePossibleCocktails(selectedIngredients: Set<String>)
}
