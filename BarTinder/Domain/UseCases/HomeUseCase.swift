//
//  HomeUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/05/2025.
//

import Foundation

class HomeUseCase {
    
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func executeSortQuery(selectedCategory: Category, from possibleCocktails: [Cocktail]) -> [Cocktail] {
        
        switch selectedCategory {
        case .possibleCocktails:
            return possibleCocktails
        case .gin:
            return possibleCocktails.filter { cocktail in
                cocktail.ingredientsMeasures.contains { $0.ingredient.lowercased() == "gin" }
            }
        case .vodka:
            return possibleCocktails.filter { cocktail in
                cocktail.ingredientsMeasures.contains { $0.ingredient.lowercased() == "vodka" }
            }
        case .vermouth:
            return possibleCocktails.filter { cocktail in
                cocktail.ingredientsMeasures.contains { $0.ingredient.lowercased() == "vermouth" }
            }
        case .whisky:
            return possibleCocktails.filter { cocktail in
                cocktail.ingredientsMeasures.contains {
                    let ing = $0.ingredient.lowercased()
                    return ing == "whisky" || ing == "rye whiskey"
                }
            }
        case .shortDrink:
            return possibleCocktails.filter { $0.style == "short" }
        case .longDrink:
            return possibleCocktails.filter { $0.style == "long" }
        }
    }
}
