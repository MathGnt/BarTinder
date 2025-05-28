//
//  CocktailRepo.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import Foundation
import SwiftData

final class CocktailRepo: Servable {

    let networkManager: NetworkManager
    private let context: ModelContext
    
    init(networkManager: NetworkManager, context: ModelContext) {
        self.networkManager = networkManager
        self.context = context
    }
    
    func contextInsert(_ cocktail: Cocktail) {
        context.insert(cocktail)
    }
    
    func contextDelete(_ cocktail: Cocktail) {
        context.delete(cocktail)
    }
    
    func contextSave() {
        do {
            try context.save()
        } catch {
            print("Save failed: \(error)")
        }
    }
    
    func getContextContent() -> [Cocktail] {
        do {
            return try context.fetch(FetchDescriptor<Cocktail>())
        } catch {
            print(VMErrors.failedFetchDescriptor(error).errorDescription as Any)
            return []
        }
    }

    func getAllCocktails() throws -> [Cocktail] {
        var cocktails: [Cocktail] = []
        do {
            let cocktailResponse = try networkManager.getCocktails()
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
            print(NetworkErrors.couldntFetchCocktails.localizedDescription)
            throw NetworkErrors.couldntFetchCocktails
        }
        return cocktails
    }
}
