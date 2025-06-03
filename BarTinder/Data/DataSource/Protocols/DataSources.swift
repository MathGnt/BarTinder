//
//  Servable.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/05/2025.
//

import Foundation
import SwiftData

protocol CocktailProvider {
    func getAllCocktails() throws -> [Cocktail]
}

protocol SwiftDataOperations {
    var swiftDataSource: SwiftDataSource { get }
}

extension SwiftDataOperations {
    
    func callContextInsert(_ cocktail: Cocktail) {
        swiftDataSource.contextInsert(cocktail)
    }
    
    func callContextDelete(_ cocktail: Cocktail) {
        swiftDataSource.contextDelete(cocktail)
    }
    
    func callContextSave() {
        swiftDataSource.contextSave()
    }
    
    func callGetContextContent() -> [Cocktail] {
        swiftDataSource.getContextContent(Cocktail.self)
    }
}

typealias Servable = CocktailProvider & SwiftDataOperations
