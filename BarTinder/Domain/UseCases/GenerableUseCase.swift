//
//  GenerableUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 03/07/2025.
//

import Foundation
import FoundationModels

final class GenerableUseCase {
    let model = SystemLanguageModel.default
    
    func executeCheckingAvailability() -> Bool {
        switch model.availability {
        case .available:
            return true
        case .unavailable(.deviceNotEligible):
            return false
        default:
            return false
        }
    }
    
    func executeCreateCocktail(cocktailIdea: CocktailIdea.PartiallyGenerated?) -> Cocktail? {
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
