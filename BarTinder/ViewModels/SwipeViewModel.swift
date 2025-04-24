//
//  SwipeViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import Foundation
import Observation

@Observable
class SwipeViewModel {
    
    
    let repo: CocktailRepo
    var cocktails: [Cocktail] = []
    var possibleCocktails: [Cocktail] = []
    var selectedIngredients: Set<String> = []
    
    init(repo: CocktailRepo) {
        self.repo = repo
    }
    
    func getCocktails() {
        do {
            let cocktails = try repo.getAllCocktails()
            self.cocktails = cocktails
        } catch {
            print(VMErrors.couldntFetchCocktails.localizedDescription as Any)
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
