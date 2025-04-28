//
//  Cocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import Foundation
import SwiftData

@Model
final class Cocktail: Identifiable {
    var name: String
    var ingredients: [String]
    var isInBar: Bool
    var image: String
    var style: String
    
    var id: String { self.name }
    
    init(name: String, ingredients: [String], isInBar: Bool, image: String, style: String) {
        self.name = name
        self.ingredients = ingredients
        self.isInBar = isInBar
        self.image = image
        self.style = style
    }
}

enum Category {
    case possibleCocktails
    case gin
    case vodka
    case vermouth
    case whisky
    case shortDrink
    case longDrink
}
