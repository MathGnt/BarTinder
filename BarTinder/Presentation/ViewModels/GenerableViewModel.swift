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
//    let useCase: GenerableUseCase
    let session: LanguageModelSession
    let model = SystemLanguageModel.default
    var cocktailIdea: CocktailIdea.PartiallyGenerated?
    var showButtons = false
    var notAvailable = false
    
    
    init() {
        self.session = LanguageModelSession(
            instructions: """
        Suggest an idea for a creative cocktail. For the measure and unit, you can help you with \(Cocktail.ginto.ingredients), \(Cocktail.mule.ingredients), \(Cocktail.spritz), \(Cocktail.martini).
        """
        )
        
    }
    
    func generate() async {
        guard checkingAvailability() else {
            notAvailable = true
            return
        }
        
        let words: [String] = ["Happiness", "Sweet", "Forest", "Coffee", "Summer", "Winter", "Music"]
        let prompt = "Give me an idea for a cocktail that represents the word \(words.randomElement() ?? "Courage")"
        let options = GenerationOptions(temperature: 2.0)
        let streamingResponse = session.streamResponse(to: prompt, generating: CocktailIdea.self, options: options)

        do {
            for try await cocktailIdea in streamingResponse {
                self.cocktailIdea = cocktailIdea
            }
            showButtons = true
        } catch LanguageModelSession.GenerationError.guardrailViolation {
            print("faut pas insulter le robot") // No longer asking user's idea
        } catch {
            print("other errror")
        }
    }
    
    func checkingAvailability() -> Bool {
        switch model.availability {
        case .available:
            return true
        case .unavailable(.deviceNotEligible):
            return false
        default:
            return false
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
        return Cocktail(name: name, ingredients: finalIngredients, isPossible: true, style: style, glass: glass, mixingTechnique: mixingTechnique, difficulty: difficulty, cocktailDescription: description)
    }
}
