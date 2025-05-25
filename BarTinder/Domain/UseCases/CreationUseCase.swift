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
    ) -> [IngredientMeasure] {
        ingredients.compactMap { ingredient in
            guard let measure = cocktailMeasure[ingredient.id] else { return nil }
            let unit = selectedUnit[ingredient.id] ?? .cl
            return IngredientMeasure(ingredient: ingredient.name, measure: "\(measure) \(unit.rawValue)")
        }
    }
    
    func createNewCocktail(_ cocktail: Cocktail) {
        repo.contextInsert(cocktail)
        repo.contextSave()
    }
    
}
