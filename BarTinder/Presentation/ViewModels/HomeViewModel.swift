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
    
    func deleteCocktail(_ cocktail: Cocktail) {
        useCase.executeDeleteCocktail(cocktail)
    }
}
