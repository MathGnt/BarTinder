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
    
    func makeDraftContext(cocktailID: PersistentIdentifier) -> (ModelContext, any PersistentModel) {
        
        guard let context else {
            return (ModelContext(try! ModelContainer(
                for: Cocktail.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )), Cocktail())
        }
        
        let modelContext = ModelContext(context.container)
        modelContext.autosaveEnabled = false
        
        let cocktail = modelContext.model(for: cocktailID)
        
        return (modelContext, cocktail)
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
