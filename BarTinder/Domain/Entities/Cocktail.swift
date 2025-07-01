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
nonisolated final class Cocktail {
    #Index<Cocktail>([\.isInBar, \.isPossible])
    
    @Attribute(.unique)
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \Ingredient.cocktail)
    var ingredients: [Ingredient]
    var isInBar: Bool
    var isPossible: Bool
    var imageName: String?
    var imageData: Data?
    var style: CocktailStyle
    var glass: CocktailGlass
    var mixingTechnique: CocktailMixingTechnique
    var difficulty: CocktailDifficulty
    // Enum rawValues for sorting
    var styleValue: String
    var glassValue: String
    var mixingTechniqueValue: String
    var difficultyValue: String
    
    var abv: String
    var flavor: String

    var cocktailDescription: String
    var stock = false
    
    init(name: String = "", ingredients: [Ingredient] = [], isInBar: Bool = false, isPossible: Bool = false, imageName: String? = nil, imageData: Data? = nil, style: CocktailStyle = CocktailStyle.shortDrink, glass: CocktailGlass = CocktailGlass.highball, mixingTechnique: CocktailMixingTechnique = CocktailMixingTechnique.built, difficulty: CocktailDifficulty = CocktailDifficulty.easy, styleValue: String = "shortdrink", glassValue: String = "highball", mixingTechniqueValue: String = "built", difficultyValue: String = "Easy", abv: String = "", flavor: String = "", cocktailDescription: String = "", stock: Bool = false) {
        self.name = name
        self.ingredients = ingredients
        self.isInBar = isInBar
        self.isPossible = isPossible
        self.imageName = imageName
        self.imageData = imageData
        self.style = style
        self.glass = glass
        self.mixingTechnique = mixingTechnique
        self.difficulty = difficulty
        self.styleValue = styleValue
        self.glassValue = glassValue
        self.mixingTechniqueValue = mixingTechniqueValue
        self.difficultyValue = difficultyValue
        self.abv = abv
        self.flavor = flavor
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

