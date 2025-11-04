/*
See the LICENSE.txt file for this sample's licensing information.

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
    /// Enum rawValues for sorting
    var styleValue: String
    var glassValue: String
    var mixingTechniqueValue: String
    var difficultyValue: String
    
    var cocktailDescription: String
    var stock = false
    
    init(name: String = "", ingredients: [Ingredient] = [], isInBar: Bool = false, isPossible: Bool = false, imageName: String? = nil, imageData: Data? = nil, style: CocktailStyle = .shortDrink, glass: CocktailGlass = .highball, mixingTechnique: CocktailMixingTechnique = .built, difficulty: CocktailDifficulty = .easy, styleValue: String = "short drink", glassValue: String = "highball", mixingTechniqueValue: String = "built", difficultyValue: String = "easy", cocktailDescription: String = "", stock: Bool = false) {
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
    
    @Transient
    var difficultyLevel: Int {
        switch difficulty {
        case .easy: return 1
        case .medium: return 2
        case .hard: return 3
        }
    }
}

//extension Cocktail: Rollbackable {
//    struct Snapshot {
//        let name: String
//        let ingredients: [Ingredient]
//        let isInBar: Bool
//        let imageData: Data?
//        let style: CocktailStyle
//        let glass: CocktailGlass
//        let mixingTechnique: CocktailMixingTechnique
//        let difficulty: CocktailDifficulty
//        let cocktailDescription: String
//    }
//
//    func createSnapshot() -> Snapshot {
//        Snapshot(
//            name: name,
//            ingredients: ingredients,
//            isInBar: isInBar,
//            imageData: imageData,
//            style: style,
//            glass: glass,
//            mixingTechnique: mixingTechnique,
//            difficulty: difficulty,
//            cocktailDescription: cocktailDescription
//        )
//    }
//
//    func restore(from snapshot: Snapshot) {
//        name = snapshot.name
//        ingredients = snapshot.ingredients
//        isInBar = snapshot.isInBar
//        imageData = snapshot.imageData
//        style = snapshot.style
//        glass = snapshot.glass
//        mixingTechnique = snapshot.mixingTechnique
//        difficulty = snapshot.difficulty
//        cocktailDescription = snapshot.cocktailDescription
//    }
//}
