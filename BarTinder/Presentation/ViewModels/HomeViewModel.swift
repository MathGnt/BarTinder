//
//  HomeViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 09/05/2025.
//

import Foundation
import SwiftData
import Observation

@Observable
@MainActor
final class HomeViewModel {
    
    let useCase: HomeUseCase
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    var selectedIngredient: Ingredient?
    var selectedCategory: Category = .possibleCocktails
    var resetConfirmation = false
    var showCreationSheet = false
    
    func sortQuery(from possibleCocktails: [Cocktail]) -> [Cocktail] {
        useCase.executeSortQuery(selectedCategory: selectedCategory, from: possibleCocktails)
    }
    
    
    // Can't use clean arch with this - swift data bugs
    func deleteCocktail(_ cocktail: Cocktail, _ context: ModelContext) {
        if cocktail.stock {
            cocktail.isPossible = false
        } else {
            context.delete(cocktail)
        }
        try? context.save()
    }
}
