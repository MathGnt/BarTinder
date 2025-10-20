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

    func getAllCocktails() throws(NetworkErrors) {
        do {
            let cocktailResponse = try cocktailDataSource.getCocktails()
            cocktailResponse.forEach { cocktail in
                let cocktailImage = cocktail.name.lowercased().replacingOccurrences(of: " ", with: "")
                
                let newCocktail = Cocktail(
                    name: cocktail.name,
                    ingredients: [],
                    isInBar: false,
                    isPossible: false,
                    imageName: cocktailImage,
                    imageData: nil,
                    style: CocktailStyle(rawValue: cocktail.style) ?? .shortDrink,
                    glass: CocktailGlass(rawValue: cocktail.glass) ?? .highball,
                    mixingTechnique: CocktailMixingTechnique(rawValue: cocktail.technique) ?? .built,
                    difficulty: CocktailDifficulty(rawValue: cocktail.difficulty) ?? .easy,
                    styleValue: cocktail.style,
                    glassValue: cocktail.glass,
                    mixingTechniqueValue: cocktail .technique,
                    difficultyValue: cocktail.difficulty,
                    cocktailDescription: cocktail.cocktailDescription,
                    stock: true
                )
                
            
                let ingredients = cocktail.ingredients.map {
                    Ingredient(name: $0.name, measure: $0.measure, unit: Units.init(rawValue: $0.unit) ?? .cl)
                }
                
                newCocktail.ingredients = ingredients
                
                swiftDataSource.contextInsert(newCocktail)
            }
        } catch {
            print("error mapping cocktail data: \(error)")
            throw .couldntMapCocktails
        }
    }
}
