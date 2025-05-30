//
//  SwiftDataSource.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 30/05/2025.
//

import Foundation
import SwiftData

final class SwiftDataSource: DataBase {
    
    let context: ModelContext?
    
    init(context: ModelContext? = nil) {
        self.context = context
    }
    
    func contextInsert<T: PersistentModel>(_ item: T) {
        context?.insert(item)
    }
    
    func contextDelete<T: PersistentModel>(_ item: T) {
        context?.delete(item)
    }
    
    func contextSave() {
        do {
            try context?.save()
        } catch {
            print("Save failed: \(error)")
        }
    }
    
    func getContextContent<T: PersistentModel>(_ type: T.Type) -> [T] {
        do {
            let fetch = try context?.fetch(FetchDescriptor<T>())
            guard let fetch else { return [] }
            return fetch
        } catch {
            print(VMErrors.failedFetchDescriptor(error).errorDescription as Any)
            return []
        }
    }
    
    func contextDeleteAll<T: PersistentModel>(_ model: T.Type) {
        do {
            try context?.delete(model: Cocktail.self)
            let all = getContextContent(Cocktail.self)
            print("all cocktails are \(all) and ingredients are \(all.map { $0.ingredientsMeasures})")
        } catch {
            print(SwiftDataErrors.failedToDeleteDataBase.localizedDescription)
        }
        contextSave()
    }
}
