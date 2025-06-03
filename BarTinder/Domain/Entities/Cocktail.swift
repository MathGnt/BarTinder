//
//  Cocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Cocktail: Identifiable {
    #Index<Cocktail>([\.isInBar, \.isPossible])
    
    @Attribute(.unique)
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \IngredientMeasure.cocktail)
    var ingredientsMeasures: [IngredientMeasure]
    var isInBar: Bool
    var isPossible: Bool
    var imageName: String?
    var imageData: Data?
    var style: String
    var glass: String
    var preparation: String
    var abv: String
    var flavor: String
    var difficulty: Int
    var cocktailDescription: String
    var stock: Bool
    
    init(name: String, ingredientsMeasures: [IngredientMeasure], isInBar: Bool, isPossible: Bool, imageName: String?, imageData: Data?, style: String, glass: String, preparation: String, abv: String, flavor: String, difficulty: Int, cocktailDescription: String, stock: Bool) {
        self.name = name
        self.ingredientsMeasures = ingredientsMeasures
        self.isInBar = isInBar
        self.isPossible = isPossible
        self.imageName = imageName
        self.imageData = imageData
        self.style = style
        self.glass = glass
        self.preparation = preparation
        self.abv = abv
        self.flavor = flavor
        self.difficulty = difficulty
        self.cocktailDescription = cocktailDescription
        self.stock = stock
    }
}

extension Cocktail {
    
    @Transient
    var displayedImage: Image {
        if let name = imageName {
            return Image(name)
        }
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return Image("defaultpic")
    }
}

//MARK: Ingredients Relationship

@Model
final class IngredientMeasure: Identifiable {
    var ingredient: String
    var measure: String
    
    var cocktail: Cocktail?
    
    var id: String { self.ingredient}
    
    init(ingredient: String, measure: String) {
        self.ingredient = ingredient
        self.measure = measure
    }
}
