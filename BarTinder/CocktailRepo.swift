//
//  CocktailRepo.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import Foundation

class CocktailRepo {

    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager    
    }

    func getAllCocktails() throws -> [Cocktail] {
        var cocktails: [Cocktail] = []
        do {
            let cocktailResponse = try networkManager.getCocktails()
            for cocktail in cocktailResponse {
                let newCocktail = Cocktail(name: cocktail.name, ingredients: cocktail.ingredients, isInBar: false)
                cocktails.append(newCocktail)
            }
        } catch {
            print(NetworkErrors.couldntFetchCocktails.localizedDescription)
            throw NetworkErrors.couldntFetchCocktails
        }
        return cocktails
    }
}
