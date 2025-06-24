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
        do {
            let cocktailResponse = try cocktailDataSource.getCocktails()
            return cocktailResponse.map { cocktail in
                let cocktailImage = cocktail.name.lowercased().replacingOccurrences(of: " ", with: "")
                
                let newCocktail = Cocktail(
                    name: cocktail.name,
                    ingredientsMeasures: [],
                    isInBar: false,
                    isPossible: false,
                    imageName: cocktailImage,
                    imageData: nil,
                    style: CocktailStyle(rawValue: cocktail.style)!,
                    glass: CocktailGlass(rawValue: cocktail.glass)!,
                    mixingTechnique: CocktailMixingTechnique(rawValue: cocktail.technique)!,
                    difficulty: CocktailDifficulty(rawValue: cocktail.difficulty)!,
                    glassValue: cocktail.glass,
                    mixingTechniqueValue: cocktail .technique,
                    difficultyValue: cocktail.difficulty,
                    abv: cocktail.abv,
                    flavor: cocktail.flavor,
                    cocktailDescription: cocktail.cocktailDescription,
                    stock: true
                )
                
            
                let ingredientMeasures = cocktail.ingredientsMeasures.map {
                    IngredientMeasure(ingredient: $0.ingredient, measure: $0.measure, cocktail: newCocktail)
                }
                
                newCocktail.ingredientsMeasures = ingredientMeasures
                
                return newCocktail
            }
        } catch {
            print("error mapping cocktail data: \(error)")
            throw .couldntMapCocktails
        }
    }
}
