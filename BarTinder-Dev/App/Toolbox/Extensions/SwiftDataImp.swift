/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A ModelContext extension to minimize in-view logic.
*/

import Foundation
import SwiftData
import SwiftUI

extension ModelContext {
    func persist<T: PersistentModel>(_ element: T) {
        if element.modelContext == nil {
            self.insert(element)
            try? self.save()
        } else {
            try? self.save()
        }
    }
    
    // Could be generic if needed while checking for the stock somewhere else
    func contextDelete(_ cocktail: Cocktail) {
        if cocktail.stock {
            cocktail.isPossible = false
        }  else {
            self.delete(cocktail)
        }
        try? self.save()
    }
    
    func getContent<T: PersistentModel>(for type: T.Type) -> [T] {
        do {
            let fetch = try self.fetch(FetchDescriptor<T>())
            return fetch
        } catch {
            print("Failed to get context content from type \(type)")
            return []
        }
    }
    
    func contains<T: PersistentModel>(_ element: T) -> Bool {
        getContent(for: T.self).contains(element)
    }
    
    func deleteAll<T: PersistentModel>(_ model: T.Type) {
        do {
            try self.delete(model: model)
        } catch {
            print("Failed to deleteAll from context: \(error)")
        }
        try? self.save()
    }
    
    func `switch`<T: PersistentModel>(for model: T) -> T {
        let editContext = ModelContext(self.container)
        editContext.autosaveEnabled = false
        return editContext.model(for: model.persistentModelID) as? T ?? model
    }
}
