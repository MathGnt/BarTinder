/*
See the LICENSE.txt file for this sample's licensing information.

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
    @Guide(description: "The ingredients for the cocktail")
    var ingredients: [IngredientIdea]
}

@Generable
struct IngredientIdea {
    @Guide(.anyOf(CardIngredient.ingredientCards.map(\.name)))
    var name: String
    @Guide(description: "A number that represent the amount", .range(1...20))
    var amount: Int
    @Guide(.anyOf(Units.allCases.map(\.rawValue)))
    var unit: String
}

#if DEBUG 
//#Playground {
//    let word = "Rain"
//    let instructions = """
//        Suggest an idea for a creative cocktail. Make sure to add a name, ingredients, and options to it. For the measure and unit, you can help you with \(Cocktail.ginto.ingredients) or \(Cocktail.mule.ingredients). The ingredient pattern should be like: 
//        measure: 5, unit: cl. or measure: 1, unit: wedge. Don't mix them. The amount should ALWAYS be a number. Please be careful about them, if you're thinking 50ml and you're using "cl" as the unit which means centiliters, you should have measure: 5, unit: cl. If you want to use "To Rinse" are "Top Up" as unit, don't generate any amount. Don't give us the same ingredient twice in the same cocktail.
//        """
//    let session = LanguageModelSession(instructions: instructions)
//    
//    let prompt = "Give me an idea for a cocktail that represents the word \(word)"
//    let response = try await session.respond(to: prompt, generating: CocktailIdea.self)
//}
#endif
