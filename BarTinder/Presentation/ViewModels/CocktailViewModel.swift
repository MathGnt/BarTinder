//
//  CocktailViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 09/05/2025.
//

import Foundation
import SwiftData
import Observation

@Observable
@MainActor
final class CocktailViewModel {
    
    let useCase: CocktailUseCase
    
    init(useCase: CocktailUseCase) {
        self.useCase = useCase
    }
    
    var selectedIngredient: Ingredient?
    var selectedCategory: Category = .possibleCocktails
    var resetConfirmation = false
    var showCreationSheet = false
    
    func sortQuery(_ possibleCocktails: [Cocktail]) -> [Cocktail] {
          useCase.executeSortQuery(selectedCategory: selectedCategory, from: possibleCocktails)
      }
    
    
    func deleteCocktail(_ cocktail: Cocktail) {
        if cocktail.stock {
            cocktail.isPossible = false
        } else {
            useCase.executeDeleteCocktail(cocktail)
        }
    }
}
