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
    var measures: [String]
    var isInBar: Bool
    var image: String
    var style: String
    var glass: String
    var preparation: String
    var abv: String
    var flavor: String
    var difficulty: Int
    var cocktailDescription: String
    
    var id: String { self.name }
    
    init(name: String, ingredients: [String], measures: [String], isInBar: Bool, image: String, style: String, glass: String, preparation: String, abv: String, flavor: String, difficulty: Int, cocktailDescription: String) {
        self.name = name
        self.ingredients = ingredients
        self.measures = measures
        self.isInBar = isInBar
        self.image = image
        self.style = style
        self.glass = glass
        self.preparation = preparation
        self.abv = abv
        self.flavor = flavor
        self.difficulty = difficulty
        self.cocktailDescription = cocktailDescription
        
       
    }
    
    static func getMock() -> Cocktail {
        return Cocktail(name: "Gin Tonic", ingredients: ["gin", "tonic water"], measures: ["6 cl", "12 cl"], isInBar: true, image: "gintonic", style: "longdrink", glass: "balloon", preparation: "Built", abv: "10", flavor: "Bitter", difficulty: 1, cocktailDescription: "Created in the early 20th century at Singapore's Raffles Hotel, this cocktail is a tropical and complex delight. Perfect for exotic evenings and resort relaxation.")
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
