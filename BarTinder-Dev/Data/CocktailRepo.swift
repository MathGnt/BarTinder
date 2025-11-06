/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The repository of the app that maps DTOs into entities.
*/

import Foundation
import SwiftData
import SwiftUI

final class CocktailRepo: Servable {
    let cocktailDataSource: CocktailDataSource
    
    init(cocktailDataSource: CocktailDataSource = CocktailDataSource()) {
        self.cocktailDataSource = cocktailDataSource
    }

    func getAllCocktails() throws(NetworkErrors) -> [Cocktail] {
        var cocktails: [Cocktail] = []
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
                
                cocktails.append(newCocktail)
            }
            return cocktails
        } catch {
            print("error mapping cocktail data: \(error)")
            throw .couldntMapCocktails
        }
    }
}

enum NetworkErrors: Error {
    case couldntMapCocktails
    case failedToGetCocktails
}
