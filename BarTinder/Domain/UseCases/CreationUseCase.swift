//
//  CreationUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation

class CreationUseCase: Buildable {
    
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func makeIngredientMeasures(
        ingredients: [Ingredient],
        cocktailMeasure: [String: String],
        selectedUnit: [String: CocktailCreationViewModel.Units]
    ) throws -> [IngredientMeasure] {
        var result: [IngredientMeasure] = []
        
        for ingredient in ingredients {
            let measure = cocktailMeasure[ingredient.id] ?? ""
            
            guard !measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                throw CUCErrors.emptyFields
            }
            
            let unit = selectedUnit[ingredient.id] ?? .cl
            result.append(IngredientMeasure(ingredient: ingredient.name, measure: "\(measure) \(unit.rawValue)"))
        }
        
        return result
    }
    
    func createNewCocktail(_ cocktail: Cocktail) {
        repo.contextInsert(cocktail)
        repo.contextSave()
    }
    
    func textValid(_ strings: String...) -> Bool {
        return strings.allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
}

