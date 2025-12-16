/*
See the LICENSE file for this project's licensing information.

Abstract:
A Generable struct used to handle all the requests made to Apple Intelligence.
*/

import Foundation
import FoundationModels
import Playgrounds

@Generable
struct CocktailIdea {
    @Guide(description: "A cool name for the cocktail")
    var name: String
    @Guide(description: "A short description for the cocktail")
    var description: String
    @Guide(.anyOf(CocktailGlass.allCases.map(\.rawValue)))
    var glass: String
    @Guide(.anyOf(CocktailMixingTechnique.allCases.map(\.rawValue)))
    var mixingTechnique: String
    @Guide(.anyOf(CocktailStyle.allCases.map(\.rawValue)))
    var style: String
    @Guide(.anyOf(CocktailDifficulty.allCases.map(\.rawValue)))
    var difficulty: String
    @Guide(description: "The ingredients for the cocktail", .maximumCount(8))
    var ingredients: [IngredientIdea]
}

@Generable
struct IngredientIdea {
    @Guide(.anyOf(CardIngredient.ingredientCards.map(\.name)))
    var name: String
    @Guide(description: "A number that represent the amount", .range(1...10))
    var amount: Int
    @Guide(.anyOf(Units.allCases.map(\.rawValue)))
    var unit: String
}

