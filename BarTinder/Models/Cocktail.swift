//
//  Cocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import Foundation
import SwiftData

@Model
final class Cocktail {
    var name: String
    var ingredients: [String]
    var isInBar: Bool
    
    init(name: String, ingredients: [String], isInBar: Bool) {
        self.name = name
        self.ingredients = ingredients
        self.isInBar = isInBar
    }
}

enum Category {
    case possibleCocktails
    case gin
    case vodka
    case vermouth
}
