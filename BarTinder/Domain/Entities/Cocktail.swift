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
nonisolated final class Cocktail: Identifiable {
    #Index<Cocktail>([\.isInBar, \.isPossible])
    
    @Attribute(.unique)
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \IngredientMeasure.cocktail)
    var ingredientsMeasures: [IngredientMeasure]
    var isInBar: Bool
    var isPossible: Bool
    var imageName: String?
    var imageData: Data?
    var style: CocktailStyle
    var glass: CocktailGlass
    var mixingTechnique: CocktailMixingTechnique
    var difficulty: CocktailDifficulty
    // Enum rawValues for sorting
    var glassValue: String
    var mixingTechniqueValue: String
    var difficultyValue: Int
    
    var abv: String
    var flavor: String

    var cocktailDescription: String
    var stock = false
    
    
    init(name: String = "", ingredientsMeasures: [IngredientMeasure] = [], isInBar: Bool = false, isPossible: Bool = false, imageName: String? = nil, imageData: Data? = nil, style: CocktailStyle = CocktailStyle.shortDrink, glass: CocktailGlass = CocktailGlass.highball, preparation: CocktailMixingTechnique = CocktailMixingTechnique.built, difficulty: CocktailDifficulty = CocktailDifficulty.easy, glassValue: String = "highball", preparationValue: String = "built", difficultyValue: Int = 1, abv: String = "", flavor: String = "", cocktailDescription: String = "", stock: Bool = false) {
        self.name = name
        self.ingredientsMeasures = ingredientsMeasures
        self.isInBar = isInBar
        self.isPossible = isPossible
        self.imageName = imageName
        self.imageData = imageData
        self.style = style
        self.glass = glass
        self.mixingTechnique = preparation
        self.difficulty = difficulty
        self.glassValue = glassValue
        self.mixingTechniqueValue = preparationValue
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

//MARK: Ingredients Relationship

@Model
nonisolated final class IngredientMeasure: Identifiable {
    var ingredient: String
    var measure: String
    
    var cocktail: Cocktail?
    
    var id = UUID()
    
    init(ingredient: String = "", measure: String = "", cocktail: Cocktail? = nil) {
        self.ingredient = ingredient
        self.measure = measure
        self.cocktail = cocktail
    }
}
