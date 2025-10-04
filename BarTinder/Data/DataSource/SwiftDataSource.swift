//
//  SwiftDataSource.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 30/05/2025.
//

import Foundation
import SwiftData

final class SwiftDataSource {
    let context: ModelContext?
    var snapshot: CocktailSnapshot?
    
    init(context: ModelContext? = nil) {
        self.context = context
    }
    
    func contextInsert<T: PersistentModel>(_ item: T) {
        context?.insert(item)
        contextSave()
    }
    
    func contextDelete(_ cocktail: Cocktail) {
        if cocktail.stock {
            cocktail.isPossible = false
        }  else {
            context?.delete(cocktail)
        }
        contextSave()
    }
    
    func contextSave() {
        do {
            try context?.save()
        } catch {
            print("Save context failed: \(error)")
        }
    }
    
    func register(_ cocktail: Cocktail) {
        snapshot = CocktailSnapshot(
            name: cocktail.name,
            ingredients: cocktail.ingredients,
            isInBar: cocktail.isInBar,
            style: cocktail.style,
            glass: cocktail.glass,
            mixingTechnique: cocktail.mixingTechnique,
            difficulty: cocktail.difficulty,
            cocktailDescription: cocktail.cocktailDescription
        )
    }
    
    func rollback(_ cocktail: Cocktail) {
        guard let snapshot else { return }
        cocktail.name = snapshot.name
        cocktail.ingredients = snapshot.ingredients
        cocktail.isInBar = snapshot.isInBar
        cocktail.style = snapshot.style
        cocktail.glass = snapshot.glass
        cocktail.mixingTechnique = snapshot.mixingTechnique
        cocktail.difficulty = snapshot.difficulty
        cocktail.cocktailDescription = snapshot.cocktailDescription
    }
    
    func getContextContent<T: PersistentModel>(_ type: T.Type) -> [T] {
        do {
            let fetch = try context?.fetch(FetchDescriptor<T>())
            guard let fetch else { return [] }
            return fetch
        } catch {
            print("Failed to getContextContent from type \(type)")
            return []
        }
    }
    
    func contextDeleteAll<T: PersistentModel>(_ model: T.Type) {
        do {
            try context?.delete(model: model)
        } catch {
            print("Failed to deleteAll from context: \(error)")
        }
        contextSave()
    }
}

struct CocktailSnapshot {
    var name: String
    var ingredients: [Ingredient]
    var isInBar: Bool
    var imageName: String?
    var imageData: Data?
    var style: CocktailStyle
    var glass: CocktailGlass
    var mixingTechnique: CocktailMixingTechnique
    var difficulty: CocktailDifficulty
    var cocktailDescription: String
}
