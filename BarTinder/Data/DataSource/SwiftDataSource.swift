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
    }
    
    func contextDelete<T: PersistentModel>(_ item: T) {
        context?.delete(item)
    }
    
    func contextSave() {
        do {
            try context?.save()
        } catch {
            print("Save context failed: \(error)")
        }
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
