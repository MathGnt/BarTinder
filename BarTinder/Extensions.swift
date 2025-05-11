//
//  Extensions.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 05/05/2025.
//

import Foundation
import SwiftData

extension String {
    var capitalizedWords: String {
        self.split(separator: " ").map { word in
            word.lowercased().hasPrefix("cl") ? String(word) : word.capitalized
        }.joined(separator: " ")
    }
    
    func logolized() -> String {
        replacingOccurrences(of: " ", with: "") + "logo"
    }
}


extension Cocktail {
    static func isInBarPredicate() -> Predicate<Cocktail> {
        return #Predicate<Cocktail> {
            $0.isInBar == true
        }
    }
    
    static func isPossiblePredicate() -> Predicate<Cocktail> {
        return #Predicate<Cocktail> {
            $0.isPossible == true
        }
    }
    
    static func cocktailAboutIngredient(ingredient: IngredientCard) -> Predicate<Cocktail> {
        let name = ingredient.name
        return #Predicate<Cocktail> {
            $0.ingredientsMeasures.contains { $0.ingredient == name }
        }
    }

}
