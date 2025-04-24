//
//  SwipeViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import Foundation

@Observable
class SwipeViewModel {
    
    var cocktails: [Cocktail] = []
    var possibleCocktails: [Cocktail] = []
    
    let networkManager: NetworkManager
    var selectedIngredients: Set<String> = []
    
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getAllCocktails() throws {
        do {
            self.cocktails = try networkManager.getCocktails()
        } catch {
            print(NetworkErrors.couldntFetchCocktails.localizedDescription)
            throw NetworkErrors.couldntFetchCocktails
        }
    }
    
    func getPossibleCocktails() {
        for cocktail in cocktails {
            let ingredientsSet = Set(cocktail.ingredients)
            
            if selectedIngredients.isSuperset(of: ingredientsSet) {
                possibleCocktails.append(cocktail)
            }
        }
    }
}
