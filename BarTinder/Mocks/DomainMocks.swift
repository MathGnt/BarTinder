//
//  Mocks.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation

class DomainMocks {
    

}

extension Ingredient {
    static let mocks: Ingredient = Ingredient(image: "gin", name: "gin", otherName: nil, AVB: "40", location: "United Kingdom", summer: true, unit: "Cl")
}

extension Cocktail {
    
    @MainActor static let mocks: Cocktail = Cocktail(
        name: "gin tonic",
        ingredientsMeasures: [
            .init(ingredient: "gin", measure: "6 cl"),
            .init(ingredient: "tonic water", measure: "12 cl")
        ],
        isInBar: false,
        isPossible: true,
        imageName: "gintonic",
        imageData: nil,
        style: "longdrink",
        glass: "balloon",
        preparation: "built",
        abv: "8",
        flavor: "bitter",
        difficulty: 1,
        cocktailDescription: "With roots in colonial India, the Gin Tonic is a crisp and refreshing classic. Ideal for warm afternoons and casual social gatherings."
    )
}
