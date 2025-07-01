//
//  RepositoryMock.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/05/2025.
//

import Foundation
import SwiftData


final class RepositoryMock: Servable {
    let swiftDataSource: SwiftDataSource
    
    init(swiftDataSource: SwiftDataSource) {
        self.swiftDataSource = swiftDataSource
    }
    
    func getAllCocktails() throws(NetworkErrors) {
        getMockCocktails()
    }
    
    
    private func getMockCocktails() {
        let cocktails: [Cocktail] =  [
            .init(
                name: "Old Fashioned",
                ingredients: [
                    .init(name: "whisky", measure: "4.5", unit: Units.cl),
                    .init(name: "sugar cane syrup", measure: "1.5", unit: Units.cl),
                    .init(name: "angostura bitters", measure: "2", unit: Units.dash),
                    .init(name: "sparkling water", measure: "1", unit: Units.cl)
                ],
                isInBar: false,
                isPossible: false,
                imageName: "oldfashioned",
                imageData: nil,
                style: .shortDrink,
                glass: .tumbler,
                mixingTechnique: .stirred,
                difficulty: .medium,
                abv: "32",
                flavor: "bitter",
                cocktailDescription: "Born in early 19th-century New York, the Old Fashioned is a timeless blend of simplicity and strength. Best enjoyed on a chilly autumn evening with jazz in the background.",
                stock: true
            ),
            .init(
                name: "Margarita",
                ingredients: [
                    .init(name: "tequila", measure: "4", unit: Units.cl),
                    .init(name: "triple sec", measure: "2", unit: Units.cl),
                    .init(name: "lime juice", measure: "2", unit: Units.cl)
                ],
                isInBar: false,
                isPossible: false,
                imageName: "margarita",
                imageData: nil,
                style: .shortDrink,
                glass: .cocktail,
                mixingTechnique: .shaken,
                difficulty: .medium,
                abv: "27",
                flavor: "sour",
                cocktailDescription: "Emerging from Mexico mid-20th century, the Margarita offers a vibrant mix of tequila and citrus. Best savored on warm summer nights with friends.",
                stock: true
            ),
            .init(
                name: "Mojito",
                ingredients: [
                    .init(name: "rum", measure: "4", unit: Units.cl),
                    .init(name: "lime", measure: "1/2", unit: Units.wedge),
                    .init(name: "mint", measure: "8", unit: Units.topUp),
                    .init(name: "sugar cane syrup", measure: "2", unit: Units.cl),
                    .init(name: "sparkling water", measure: "top up", unit: Units.topUp)
                ],
                isInBar: false,
                isPossible: false,
                imageName: "mojito",
                imageData: nil,
                style: .longDrink,
                glass: .highball,
                mixingTechnique: .built,
                difficulty: .medium,
                abv: "12",
                flavor: "fresh",
                cocktailDescription: "A refreshing Cuban classic dating back to the 16th century, the Mojito blends mint and lime for a crisp taste. Ideal for hot summer days and lively gatherings.",
                stock: true
            ),
            .init(
                name: "Cosmopolitan",
                ingredients: [
                    .init(name: "vodka", measure: "4", unit: Units.cl),
                    .init(name: "triple sec", measure: "1.5", unit: Units.cl),
                    .init(name: "cranberry juice", measure: "3", unit: Units.cl),
                    .init(name: "lime juice", measure: "1", unit: Units.cl)
                ],
                isInBar: false,
                isPossible: false,
                imageName: "cosmopolitan",
                imageData: nil,
                style: .shortDrink,
                glass: .cocktail,
                mixingTechnique: .shaken,
                difficulty: .medium,
                abv: "25",
                flavor: "fruity",
                cocktailDescription: "Popularized in the 1990s, the Cosmopolitan is a chic and tangy cocktail. Best enjoyed during lively urban nights and festive occasions.",
                stock: true
            )
        ]
        
        for cocktail in cocktails {
            swiftDataSource.contextInsert(cocktail)
        }
    }
}
