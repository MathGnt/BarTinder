/*
See the LICENSE file for this project's licensing information.

Abstract:
Mock data for the domain layer.
*/

import Foundation

extension Ingredient {
    @MainActor static let gin: Ingredient = Ingredient(name: "gin", measure: "6", unit: .cl)
}

extension Cocktail {
    @MainActor static let mocksArray: [Cocktail] = [
        .ginto, .mule, .spritz
    ]
    
    @MainActor static let ginto: Cocktail = Cocktail(
        name: "Gin Tonic",
        ingredients: [
            .init(name: "gin", measure: "6", unit: Units.cl),
            .init(name: "tonic water", measure: "12", unit: Units.cl)
        ],
        isInBar: true,
        isPossible: true,
        imageName: "gintonic",
        imageData: nil,
        style: .longDrink,
        glass: .balloon,
        mixingTechnique: .built,
        difficulty: .easy,
        styleValue: "long drink",
        glassValue: "balloon",
        mixingTechniqueValue: "built",
        difficultyValue: "easy",
        cocktailDescription: "With roots in colonial India, the Gin Tonic is a crisp and refreshing classic. Ideal for warm afternoons and casual social gatherings.",
        stock: true
    )
    
    @MainActor static let mule: Cocktail = Cocktail(
        name: "Moscow Mule",
        ingredients: [
            .init(name: "ginger beer", measure: "12", unit: Units.cl),
            .init(name: "lime juice", measure: "2", unit: Units.cl),
            .init(name: "vodka", measure: "5", unit: Units.cl)
        ],
        isInBar: false,
        isPossible: true,
        imageName: "moscowmule",
        imageData: nil,
        style: .longDrink,
        glass: .coppermug,
        mixingTechnique: .built,
        difficulty: .medium,
        styleValue: "long drink",
        glassValue: "coppermug",
        mixingTechniqueValue: "built",
        difficultyValue: "medium",
        cocktailDescription: "With roots in colonial India, the Gin Tonic is a crisp and refreshing classic. Ideal for warm afternoons and casual social gatherings.",
        stock: true
    )
    
    @MainActor static let spritz: Cocktail = Cocktail(
        name: "Aperol Spritz",
        ingredients: [
            .init(name: "aperol", measure: "6", unit: Units.cl),
            .init(name: "prosecco", measure: "9", unit: Units.cl),
            .init(name: "sparkling water", measure: "", unit: Units.topUp)
        ],
        isInBar: false,
        isPossible: true,
        imageName: "aperolspritz",
        imageData: nil,
        style: .longDrink,
        glass: .wine,
        mixingTechnique: .built,
        difficulty: .easy,
        styleValue: "long drink",
        glassValue: "wine",
        mixingTechniqueValue: "built",
        difficultyValue: "easy",
        cocktailDescription: "Aperol Spritz is a refreshing Italian cocktail known for its vibrant color and slightly bitter, citrusy taste. Perfect for sunny evenings.",
        stock: false
    )
}
