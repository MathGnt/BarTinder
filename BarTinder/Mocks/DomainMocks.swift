//
//  DomainMocks.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation

extension CardIngredient {
    @MainActor static let mocks: CardIngredient = CardIngredient(image: "gin", name: "gin", otherName: nil, abv: "40", location: "United Kingdom", summer: true, unit: "Cl")
}

extension Cocktail {
    
    @MainActor static let mocks: Cocktail = Cocktail(
        name: "Gin Tonic",
        ingredients: [
            .init(name: "gin", measure: "6", unit: Units.cl),
            .init(name: "tonic water", measure: "12", unit: Units.cl)
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
        abv: "8",
        flavor: "bitter",
        cocktailDescription: "With roots in colonial India, the Gin Tonic is a crisp and refreshing classic. Ideal for warm afternoons and casual social gatherings.",
        stock: false
    )
    
    @MainActor static let spritz: Cocktail = Cocktail(
        name: "Aperol Spritz",
        ingredients: [
            .init(name: "aperol", measure: "6", unit: Units.cl),
            .init(name: "prosecco", measure: "9", unit: Units.cl),
            .init(name: "sparkling water", measure: "3", unit: Units.cl)
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
        abv: "24",
        flavor: "bitter",
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
        abv: "10",
        flavor: "fresh",
        cocktailDescription: "A Cuban classic combining rum, mint, and lime. Mojito is the ultimate refreshment for hot summer days.",
        stock: false
    )
    
    @MainActor static let martini: Cocktail = Cocktail(
        name: "Martini",
        ingredients: [
            .init(name: "gin", measure: "5", unit: Units.cl),
            .init(name: "vermouth", measure: "1", unit: Units.cl)
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
