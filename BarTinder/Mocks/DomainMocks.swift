//
//  DomainMocks.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation

extension CardIngredient {
    @MainActor static let gin: CardIngredient = CardIngredient(image: "gin", name: "gin", otherName: nil, abv: "10", location: "United Kingdom", summer: true, unit: "Cl")
}

extension Ingredient {
    @MainActor static let gin: Ingredient = Ingredient(name: "gin", measure: "6", unit: .cl)
}

extension Cocktail {
    @MainActor static let mocksArray: [Cocktail] = [
        .ginto, .mule, .spritz, .negroni, .mojito, .martini
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
        stock: true
    )

    @MainActor static let negroni: Cocktail = Cocktail(
        name: "Negroni",
        ingredients: [
            .init(name: "gin", measure: "3", unit: Units.cl),
            .init(name: "campari", measure: "3", unit: Units.cl),
            .init(name: "vermouth", measure: "3", unit: Units.cl)
        ],
        isInBar: false,
        isPossible: true,
        imageName: "negroni",
        imageData: nil,
        style: .shortDrink,
        glass: .highball,
        mixingTechnique: .stirred,
        difficulty: .medium,
        styleValue: "short drink",
        glassValue: "highball",
        mixingTechniqueValue: "stirred",
        difficultyValue: "medium",
        cocktailDescription: "Bold and complex, the Negroni blends gin, vermouth, and Campari into a timeless Italian classic.",
        stock: false
    )

    @MainActor static let mojito: Cocktail = Cocktail(
        name: "Mojito",
        ingredients: [
            .init(name: "white rum", measure: "5", unit: Units.cl),
            .init(name: "lime juice", measure: "2", unit: Units.cl),
            .init(name: "sugar syrup", measure: "2", unit: Units.cl),
            .init(name: "sparkling water", measure: "top up", unit: Units.cl),
            .init(name: "mint", measure: "8", unit: Units.topUp)
        ],
        isInBar: false,
        isPossible: true,
        imageName: "mojito",
        imageData: nil,
        style: .longDrink,
        glass: .highball,
        mixingTechnique: .built,
        difficulty: .medium,
        styleValue: "long drink",
        glassValue: "highball",
        mixingTechniqueValue: "built",
        difficultyValue: "medium",
        cocktailDescription: "A Cuban classic combining rum, mint, and lime. Mojito is the ultimate refreshment for hot summer days.",
        stock: true
    )
    
    @MainActor static let martini: Cocktail = Cocktail(
        name: "Martini",
        ingredients: [
            .init(name: "gin", measure: "5", unit: Units.cl),
            .init(name: "vermouth", measure: "", unit: Units.toRinse)
        ],
        isInBar: false,
        isPossible: true,
        imageName: "drymartini",
        imageData: nil,
        style: .shortDrink,
        glass: .cocktail,
        mixingTechnique: .built,
        difficulty: .medium,
        styleValue: "short drink",
        glassValue: "cocktail",
        mixingTechniqueValue: "built",
        difficultyValue: "medium",
        cocktailDescription: "A classic served with gin and a slight amount of vermouth on the ice",
        stock: true
    )
}
