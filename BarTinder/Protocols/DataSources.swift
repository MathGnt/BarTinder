//
//  Servable.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/05/2025.
//

import Foundation
import SwiftData

protocol Servable {
    func getAllCocktails() throws -> [Cocktail]
    func callContextInsert(_ cocktail: Cocktail)
    func callContextDelete(_ cocktail: Cocktail)
    func callContextSave()
    func callGetContextContent() -> [Cocktail]
}

protocol DataBase {
    func contextInsert<T: PersistentModel>(_ item: T) 
    func contextDelete<T: PersistentModel>(_ item: T)
    func contextSave()
    func getContextContent<T: PersistentModel>(_ type: T.Type) -> [T]
}
