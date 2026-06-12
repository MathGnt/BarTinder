/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftData persistent model to store the cocktails created by the user.
*/

import Foundation
import SwiftData
import SwiftUI

@Model
final class Cocktail {
    #Index<Cocktail>([\.isInBar, \.isPossible])

    @Attribute(.unique)
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \Ingredient.cocktail)
    var ingredients: [Ingredient]
    var isInBar: Bool
    var isPossible: Bool
    var imageName: String?
    @Attribute(.externalStorage)
    var imageData: Data?
    var style: CocktailStyle
    var glass: CocktailGlass
    var mixingTechnique: CocktailMixingTechnique
    var difficulty: CocktailDifficulty
    
    var cocktailDescription: String
    var stock = false
    
    init(
        name: String = "",
        ingredients: [Ingredient] = [],
        isInBar: Bool = false,
        isPossible: Bool = false,
        imageName: String? = nil,
        imageData: Data? = nil,
        style: CocktailStyle = .shortDrink,
        glass: CocktailGlass = .highball,
        mixingTechnique: CocktailMixingTechnique = .built,
        difficulty: CocktailDifficulty = .easy,
        styleValue: String = "short drink",
        glassValue: String = "highball",
        mixingTechniqueValue: String = "built",
        difficultyValue: String = "easy",
        cocktailDescription: String = "",
        stock: Bool = false
    ) {
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
