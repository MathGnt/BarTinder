/*
See the LICENSE file for this project's licensing information.

Abstract:
A ModelContext extension to minimize in-view logic.
*/

import Foundation
import SwiftData
import SwiftUI

extension ModelContext {
    func `switch`<T: PersistentModel>(for model: T) -> T {
        let ctx = ModelContext(self.container)
        ctx.autosaveEnabled = false
        guard model.modelContext != nil else {
            ctx.insert(model)
            return model
        }
        return ctx.model(for: model.persistentModelID) as? T ?? model
    }
    
    // Could be generic if needed while checking for the `stock` somewhere else
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
    
    func deleteAll<T: PersistentModel>(_ model: T.Type) {
        do {
            try self.delete(model: model)
        } catch {
            print("Failed to deleteAll from context: \(error)")
        }
        try? self.save()
    }
}
