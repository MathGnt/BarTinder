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
    @Attribute(.unique)
    var name: String
    @Relationship(deleteRule: .cascade)
    var ingredientsMeasures: [IngredientMeasure]
    var isInBar: Bool
    var isPossible: Bool
    var image: String
    var style: String
    var glass: String
    var preparation: String
    var abv: String
    var flavor: String
    var difficulty: Int
    var cocktailDescription: String
    
    var id: String { self.name }
    
    init(name: String, ingredientsMeasures: [IngredientMeasure], isInBar: Bool, isPossible: Bool, image: String, style: String, glass: String, preparation: String, abv: String, flavor: String, difficulty: Int, cocktailDescription: String) {
        self.name = name
        self.ingredientsMeasures = ingredientsMeasures
        self.isInBar = isInBar
        self.isPossible = isPossible
        self.image = image
        self.style = style
        self.glass = glass
        self.preparation = preparation
        self.abv = abv
        self.flavor = flavor
        self.difficulty = difficulty
        self.cocktailDescription = cocktailDescription
    }
}

@Model
class IngredientMeasure: Identifiable {
    var ingredient: String
    var measure: String
    
    @Relationship var cocktail: Cocktail?
    
    var id = UUID()
    
    init(ingredient: String, measure: String, id: UUID = UUID()) {
        self.ingredient = ingredient
        self.measure = measure
        self.id = id
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
