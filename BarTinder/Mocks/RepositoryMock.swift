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
            .init(name: "Gin Tonic", ingredientsMeasures: [], isInBar: true, isPossible: true, imageName: "gintonic", imageData: nil, style: "long drinks", glass: "highball", preparation: "Built", abv: "14", flavor: "Bitter", difficulty: 1, cocktailDescription: "Gin Tonic is the best cocktail in the world")
        ]
        
        return cocktails
    }
    
    
}
