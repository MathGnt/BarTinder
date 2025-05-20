//
//  RepositoryMock.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/05/2025.
//

import Foundation

final class RepositoryMock: Servable {
    func getAllCocktails() throws -> [Cocktail] {
        let cocktails: [Cocktail] = [
            .init(
                name: "Old Fashioned",
                ingredientsMeasures: [
                    .init(ingredient: "whisky", measure: "4.5 cl"),
                    .init(ingredient: "sugar cane syrup", measure: "1.5 cl"),
                    .init(ingredient: "angostura bitters", measure: "2 dashes"),
                    .init(ingredient: "sparkling water", measure: "1 cl")
                ],
                isInBar: false,
                isPossible: false,
                imageName: "oldfashioned",
                imageData: nil,
                style: "shortdrink",
                glass: "tumbler",
                preparation: "stirred",
                abv: "32",
                flavor: "bitter",
                difficulty: 2,
                cocktailDescription: "Born in early 19th-century New York, the Old Fashioned is a timeless blend of simplicity and strength. Best enjoyed on a chilly autumn evening with jazz in the background."
            ),
            .init(
                name: "Margarita",
                ingredientsMeasures: [
                    .init(ingredient: "tequila", measure: "4 cl"),
                    .init(ingredient: "triple sec", measure: "2 cl"),
                    .init(ingredient: "lime juice", measure: "2 cl")
                ],
                isInBar: false,
                isPossible: false,
                imageName: "margarita",
                imageData: nil,
                style: "shortdrink",
                glass: "cocktail",
                preparation: "shaken",
                abv: "27",
                flavor: "sour",
                difficulty: 2,
                cocktailDescription: "Emerging from Mexico mid-20th century, the Margarita offers a vibrant mix of tequila and citrus. Best savored on warm summer nights with friends."
            ),
            .init(
                name: "Mojito",
                ingredientsMeasures: [
                    .init(ingredient: "rum", measure: "4 cl"),
                    .init(ingredient: "lime", measure: "1/2"),
                    .init(ingredient: "mint", measure: "8 leaves"),
                    .init(ingredient: "sugar cane syrup", measure: "2 cl"),
                    .init(ingredient: "sparkling water", measure: "top up")
                ],
                isInBar: false,
                isPossible: false,
                imageName: "mojito",
                imageData: nil,
                style: "longdrink",
                glass: "highball",
                preparation: "built",
                abv: "12",
                flavor: "fresh",
                difficulty: 2,
                cocktailDescription: "A refreshing Cuban classic dating back to the 16th century, the Mojito blends mint and lime for a crisp taste. Ideal for hot summer days and lively gatherings."
            ),
            .init(
                name: "Cosmopolitan",
                ingredientsMeasures: [
                    .init(ingredient: "vodka", measure: "4 cl"),
                    .init(ingredient: "triple sec", measure: "1.5 cl"),
                    .init(ingredient: "cranberry juice", measure: "3 cl"),
                    .init(ingredient: "lime juice", measure: "1 cl")
                ],
                isInBar: false,
                isPossible: false,
                imageName: "cosmopolitan",
                imageData: nil,
                style: "shortdrink",
                glass: "cocktail",
                preparation: "shaken",
                abv: "25",
                flavor: "fruity",
                difficulty: 2,
                cocktailDescription: "Popularized in the 1990s, the Cosmopolitan is a chic and tangy cocktail. Best enjoyed during lively urban nights and festive occasions."
            )
        ]
        
        return cocktails
    }
    
    
}
