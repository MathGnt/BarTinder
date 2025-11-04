/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A ModelContext extension to minimize in-view logic.
*/

import Foundation
import SwiftData
import SwiftUI

//protocol Rollbackable {
//    associatedtype Snapshot
//    func createSnapshot() -> Snapshot
//    func restore(from snapshot: Snapshot)
//}
//


//extension ModelContext {
//    private static var snapshots: [ObjectIdentifier: Any] = [:]
//    
//    func registerSnapshot<T: PersistentModel & Rollbackable>(_ object: T) {
//        let key = ObjectIdentifier(object)
//        ModelContext.snapshots[key] = object.createSnapshot()
//    }
//    
//    func rollbackSnapshot<T: PersistentModel & Rollbackable>(_ object: T) {
//        let key = ObjectIdentifier(object)
//        guard let snapshot = ModelContext.snapshots[key] as? T.Snapshot else { return }
//        object.restore(from: snapshot)
//        ModelContext.snapshots.removeValue(forKey: key)
//    }
//    
//    func rollbackAllSnapshots() {
//        // Note: Cette approche nécessiterait de stocker aussi les références aux objets
//        // ou d'utiliser une structure différente
//        ModelContext.snapshots.removeAll()
//    }
//    
//    func clearSnapshot<T: PersistentModel & Rollbackable>(_ object: T) {
//        let key = ObjectIdentifier(object)
//        ModelContext.snapshots.removeValue(forKey: key)
//    }
//}

extension ModelContext {
    func contextInsert<T: PersistentModel>(_ item: T) {
        self.insert(item)
        contextSave()
    }
    
    func contextDelete(_ cocktail: Cocktail) {
        if cocktail.stock {
            cocktail.isPossible = false
        }  else {
            self.delete(cocktail)
        }
        contextSave()
    }
    
    private func contextSave() {
        do {
            try self.save()
        } catch {
            print("Save context failed: \(error)")
        }
    }
    
    func getContent<T: PersistentModel>(for type: T.Type) -> [T] {
        do {
            let fetch = try self.fetch(FetchDescriptor<T>())
            return fetch
        } catch {
            print("Failed to getContextContent from type \(type)")
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
        contextSave()
    }
    
    func `switch`<T: PersistentModel>(for model: T) -> T {
        let editContext = ModelContext(self.container)
        editContext.autosaveEnabled = false
        return editContext.model(for: model.persistentModelID) as! T
    }
}

