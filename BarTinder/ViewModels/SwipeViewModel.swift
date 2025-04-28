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
    var selectedCategory: Category = .possibleCocktails
    var sortedCocktails: [Cocktail] {
        switch selectedCategory {
        case .possibleCocktails:
            return possibleCocktails
        case .gin:
            return possibleCocktails.filter { $0.ingredients.contains("gin") }
        case .vodka:
            return possibleCocktails.filter { $0.ingredients.contains("vodka") }
        case .vermouth:
            return possibleCocktails.filter { $0.ingredients.contains("vermouth") }
        case .whisky:
            return possibleCocktails.filter { $0.ingredients.contains("whisky") || $0.ingredients.contains("rye whiskey") }
        case .shortDrink:
            return possibleCocktails.filter { $0.style == "short" }
        case .longDrink:
            return possibleCocktails.filter { $0.style == "long" }
        }
    }
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
    
    func addIngredient(card: IngredientCard) {
        selectedIngredients.insert(card.name)
    }
    
    func getPossibleCocktails() {
        for cocktail in cocktails {
            let ingredientsSet = Set(cocktail.ingredients)
            
            if selectedIngredients.isSuperset(of: ingredientsSet) {
                possibleCocktails.append(cocktail)
            }
        }
    }
    
    func mockPossibleCocktails() {
        possibleCocktails.append(contentsOf: cocktails)
    }
}
