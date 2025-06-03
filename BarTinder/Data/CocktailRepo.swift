//
//  CocktailRepo.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import Foundation
import SwiftData
import SwiftUI

final class CocktailRepo: Servable {

    let cocktailDataSource: CocktailDataSource
    let swiftDataSource: SwiftDataSource
    
    init(cocktailDataSource: CocktailDataSource, swiftDataSource: SwiftDataSource) {
        self.cocktailDataSource = cocktailDataSource
        self.swiftDataSource = swiftDataSource
    }

    func getAllCocktails() throws(NetworkErrors) -> [Cocktail] {
        var cocktails: [Cocktail] = []
        do {
            let cocktailResponse = try cocktailDataSource.getCocktails()
            for cocktail in cocktailResponse {
                let cocktailImage = cocktail.name.lowercased().replacingOccurrences(of: " ", with: "")
                let ingredientMeasure = cocktail.ingredientsMeasures.map { IngredientMeasure(ingredient: $0.ingredient, measure: $0.measure )}
                let newCocktail = Cocktail(
                    name: cocktail.name,
                    ingredientsMeasures: ingredientMeasure,
                    isInBar: false,
                    isPossible: false,
                    imageName: cocktailImage,
                    imageData: nil,
                    style: cocktail.style,
                    glass: cocktail.glass,
                    preparation: cocktail.preparation,
                    abv: cocktail.abv,
                    flavor: cocktail.flavor,
                    difficulty: cocktail.difficulty,
                    cocktailDescription: cocktail.cocktailDescription,
                    stock: cocktail.stock
                )
                cocktails.append(newCocktail)
            }
        } catch {
            print("error mapping cocktail data: \(error)")
            throw .couldntMapCocktails
        }
        return cocktails
    }
}
