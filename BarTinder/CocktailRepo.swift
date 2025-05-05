//
//  CocktailRepo.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import Foundation

class CocktailRepo: Servable {

    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager    
    }

    func getAllCocktails() throws -> [Cocktail] {
        var cocktails: [Cocktail] = []
        do {
            let cocktailResponse = try networkManager.getCocktails()
            for cocktail in cocktailResponse {
                let cocktailImage = cocktail.name.lowercased().replacingOccurrences(of: " ", with: "")
                let newCocktail = Cocktail(name: cocktail.name, ingredients: cocktail.ingredients, measures: cocktail.measures, isInBar: false, image: cocktailImage, style: cocktail.style, glass: cocktail.glass, preparation: cocktail.preparation, abv: cocktail.abv, flavor: cocktail.flavor, difficulty: cocktail.difficulty, cocktailDescription: cocktail.cocktailDescription)
                cocktails.append(newCocktail)
            }
        } catch {
            print(NetworkErrors.couldntFetchCocktails.localizedDescription)
            throw NetworkErrors.couldntFetchCocktails
        }
        return cocktails
    }
}
