//
//  Mocks.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation

extension Ingredient {
    static let mocks: Ingredient = Ingredient(image: "gin", name: "gin", otherName: nil, AVB: "40", location: "United Kingdom", summer: true, unit: "Cl")
}

extension Cocktail {
    
    @MainActor static let mocks: Cocktail = Cocktail(
        name: "Gin Tonic",
        ingredientsMeasures: [
            .init(ingredient: "cachaca", measure: "6 cl"),
            .init(ingredient: "lime juice", measure: "12 cl"),
            .init(ingredient: "vodka", measure: "3 cl")
        ],
        isInBar: false,
        isPossible: true,
        imageName: "gintonic",
        imageData: nil,
        style: .longDrink,
        glass: .balloon,
        mixingTechnique: .built,
        difficulty: .easy,
        abv: "8",
        flavor: "bitter",
        cocktailDescription: "With roots in colonial India, the Gin Tonic is a crisp and refreshing classic. Ideal for warm afternoons and casual social gatherings.",
        stock: false
    )
    
    @MainActor static let mule: Cocktail = Cocktail(
        name: "Moscow Mule",
        ingredientsMeasures: [
            .init(ingredient: "gingerbeer", measure: "6 cl"),
            .init(ingredient: "lime juice", measure: "12 cl"),
            .init(ingredient: "vodka", measure: "3 cl")
        ],
        isInBar: false,
        isPossible: true,
        imageName: "moscowmule",
        imageData: nil,
        style: .longDrink,
        glass: .coppermug,
        mixingTechnique: .built,
        difficulty: .medium,
        abv: "8",
        flavor: "bitter",
        cocktailDescription: "With roots in colonial India, the Gin Tonic is a crisp and refreshing classic. Ideal for warm afternoons and casual social gatherings.",
        stock: false
    )
    
    @MainActor static let spritz: Cocktail = Cocktail(
        name: "Aperol Spritz",
        ingredientsMeasures: [
            .init(ingredient: "aperol", measure: "6 cl"),
            .init(ingredient: "prosecco", measure: "9 cl"),
            .init(ingredient: "sparkling water", measure: "3 cl")
        ],
        isInBar: false,
        isPossible: true,
        imageName: "aperolspritz",
        imageData: nil,
        style: .longDrink,
        glass: .wine,
        mixingTechnique: .built,
        difficulty: .easy,
        abv: "11",
        flavor: "bitter-sweet",
        cocktailDescription: "Aperol Spritz is a refreshing Italian cocktail known for its vibrant color and slightly bitter, citrusy taste. Perfect for sunny evenings.",
        stock: false
    )

    @MainActor static let negroni: Cocktail = Cocktail(
        name: "Negroni",
        ingredientsMeasures: [
            .init(ingredient: "gin", measure: "3 cl"),
            .init(ingredient: "campari", measure: "3 cl"),
            .init(ingredient: "vermouth", measure: "3 cl")
        ],
        isInBar: false,
        isPossible: true,
        imageName: "negroni",
        imageData: nil,
        style: .shortDrink,
        glass: .highball,
        mixingTechnique: .stirred,
        difficulty: .medium,
        abv: "24",
        flavor: "bitter",
        cocktailDescription: "Bold and complex, the Negroni blends gin, vermouth, and Campari into a timeless Italian classic.",
        stock: false
    )

    @MainActor static let mojito: Cocktail = Cocktail(
        name: "Mojito",
        ingredientsMeasures: [
            .init(ingredient: "white rum", measure: "5 cl"),
            .init(ingredient: "lime juice", measure: "2 cl"),
            .init(ingredient: "sugar syrup", measure: "2 cl"),
            .init(ingredient: "sparkling water", measure: "top up"),
            .init(ingredient: "mint", measure: "8 leaves")
        ],
        isInBar: false,
        isPossible: true,
        imageName: "mojito",
        imageData: nil,
        style: .longDrink,
        glass: .highball,
        mixingTechnique: .built,
        difficulty: .medium,
        abv: "10",
        flavor: "fresh",
        cocktailDescription: "A Cuban classic combining rum, mint, and lime. Mojito is the ultimate refreshment for hot summer days.",
        stock: false
    )
    
    @MainActor static let martini: Cocktail = Cocktail(
        name: "Martini",
        ingredientsMeasures: [
            .init(ingredient: "gin", measure: "5 cl"),
            .init(ingredient: "vermouth", measure: "1 cl"),
        ],
        isInBar: false,
        isPossible: true,
        imageName: "drymartini",
        imageData: nil,
        style: .shortDrink,
        glass: .cocktail,
        mixingTechnique: .built,
        difficulty: .medium,
        abv: "10",
        flavor: "strong",
        cocktailDescription: "A classic served with gin and a slight amount of vermouth on the ice",
        stock: false
    )
}
