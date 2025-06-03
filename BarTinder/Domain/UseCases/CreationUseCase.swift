//
//  CreationUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation

class CreationUseCase {
    
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    
    func makeIngredientMeasures(
        ingredients: [Ingredient],
        cocktailMeasure: [String : String],
        selectedUnit: [String : Units]
    ) throws -> [IngredientMeasure] {
        var result: [IngredientMeasure] = []
        
        for ingredient in ingredients {
          
            let unit = selectedUnit[ingredient.id] ?? .cl
            
            switch unit {
            case .topUp, .toRinse:
                let argIng = makeArgumentIngredient(selectedUnit, ingredient, unit)
                result.append(argIng)
            default:
                let regIng = try makeRegularIngredient(cocktailMeasure, selectedUnit, ingredient, unit)
                result.append(regIng)
            }
        }
        return result
    }
    
    func makeArgumentIngredient(
        _ selectedUnit: [String : Units],
        _ ingredient: Ingredient,
        _ unit: Units
    ) -> IngredientMeasure {
        
        let newIngredient: IngredientMeasure = IngredientMeasure(
            ingredient: ingredient.name,
            measure: unit.rawValue
        )
        
        return newIngredient
    }
    
    func makeRegularIngredient(
        _ cocktailMeasure: [String : String],
        _ selectedUnit: [String : Units],
        _ ingredient: Ingredient,
        _ unit: Units
    ) throws -> IngredientMeasure {
        
        let measure = cocktailMeasure[ingredient.id] ?? ""
        guard !measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw CUCErrors.emptyFields
        }
        
        let newIngredient: IngredientMeasure = IngredientMeasure(
            ingredient: ingredient.name,
            measure: "\(measure) \(unit.rawValue)"
        )
        
        return newIngredient
    }
    
    func createNewCocktail(_ cocktail: Cocktail) {
        repo.callContextInsert(cocktail)
        repo.callContextSave()
    }
    
    func textValid(_ strings: String...) -> Bool {
        return strings.allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
}
