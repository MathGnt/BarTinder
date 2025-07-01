//
//  GenerableCocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/07/2025.
//

import Foundation
import FoundationModels
import Playgrounds

@Generable
struct CocktailIdea {
    @Guide(description: "A cool name for the cocktail")
    var name: String
    var ingredients: [IngredientIdea]
    @Guide(.anyOf(CocktailStyle.allCases.map { $0.rawValue }))
    var style: String
    @Guide(.anyOf(CocktailGlass.allCases.map { $0.rawValue }))
    var glass: String
    @Guide(.anyOf(CocktailMixingTechnique.allCases.map { $0.rawValue }))
    var mixingTechnique: String
    @Guide(.anyOf(CocktailDifficulty.allCases.map { $0.rawValue }))
    var difficulty: String
    @Guide(description: "the average ABV for this cocktail")
    var abv: Int
    @Guide(description: "The flavor of the cocktail")
    var flavor: String
    @Guide(description: "A short story that describe the cocktail")
    var description: String
}

@Generable
struct IngredientIdea {
    @Guide(.anyOf(CardIngredient.ingredientCards.map { $0.name}))
    var name: String
    @Guide(description: "A number that represent the amount")
    var amount: String
    @Guide(.anyOf(Units.allCases.map { $0.rawValue }))
    var unit: String
}


#Playground {
    let word = "Hot evening"
    let instructions = """
        Suggest an idea for a creative cocktail. Make sure to add a name, ingredients, and options to it. For the measure and unit, you can help you with \(Cocktail.ginto.ingredients) or \(Cocktail.mule.ingredients). The ingredient pattern should be like: 
        measure: 5, unit: cl. or measure: 1, unit: wedge. Don't mix them. The amount should ALWAYS be a number. Please be careful about them, if you're thinking 50ml and you're using "cl" as the unit which means centiliters, you should have measure: 5, unit: cl.
        """
    let session = LanguageModelSession(instructions: instructions)
    
//    let prompt = "Give me an idea for a cocktail that represents the word \(word)"
//    let response = try await session.respond(to: prompt, generating: CocktailIdea.self)
}
