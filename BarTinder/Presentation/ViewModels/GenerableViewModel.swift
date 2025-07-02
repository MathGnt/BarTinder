//
//  GenerableViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/07/2025.
//

import Foundation
import FoundationModels

@Observable
final class GenerableViewModel {
    let session: LanguageModelSession
    var cocktailIdea: CocktailIdea.PartiallyGenerated?
    var mood = ""
    var streamingError = false
    
    init() {
        self.session = LanguageModelSession(
            instructions: """
        Suggest an idea for a creative cocktail. For the measure and unit, you can help you with \(Cocktail.ginto.ingredients) or \(Cocktail.mule.ingredients). The ingredient pattern should be like: 
        measure: 5, unit: cl. or measure: 1, unit: wedge. If you're thinking 50ml and you're using "cl" as the unit which means centiliters, you should have measure: 5, unit: cl.
        """
        )
    }
    
    func prewarm() {
        session.prewarm()
    }
    
    func generate() async {
        let prompt = "Give me an idea for a cocktail that represents the word \(mood)"
        let streamingResponse = session.streamResponse(to: prompt, generating: CocktailIdea.self)
        print("prompt is: \(prompt)")
        do {
            for try await cocktailIdea in streamingResponse {
                self.cocktailIdea = cocktailIdea
            }
        } catch LanguageModelSession.GenerationError.guardrailViolation {
            streamingError = true
            print("error during streaming")
        } catch {
            print("other errror")
        }
    }
    
    func createCocktail() -> Cocktail? {
        var finalIngredients: [Ingredient] = []
        
        guard let cocktailIdea else { return nil }
        guard let name = cocktailIdea.name else { return nil }
        guard let description = cocktailIdea.description else { return nil }
        guard let ingredients = cocktailIdea.ingredients else { return nil }
        guard let style = CocktailStyle(rawValue: cocktailIdea.style!) else { return nil }
        guard let glass = CocktailGlass(rawValue: cocktailIdea.glass!) else { return nil }
        guard let mixingTechnique = CocktailMixingTechnique(rawValue: cocktailIdea.mixingTechnique!) else { return nil }
        guard let difficulty = CocktailDifficulty(rawValue: cocktailIdea.difficulty!) else { return nil }
        
        
        for ingredient in ingredients {
            guard let ingredientName = ingredient.name else { return nil }
            guard let ingredientMeasure = ingredient.amount else { return nil }
            guard let ingredientUnit = Units(rawValue: ingredient.unit!) else { return nil }
            
            let newIngredient = Ingredient(name: ingredientName, measure: String(ingredientMeasure), unit: ingredientUnit)
            finalIngredients.append(newIngredient)
            
        }
        return Cocktail(name: name, ingredients: finalIngredients, style: style, glass: glass, mixingTechnique: mixingTechnique, difficulty: difficulty, cocktailDescription: description)
    }
}
