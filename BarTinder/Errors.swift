//
//  Errors.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import Foundation


enum NetworkErrors: Error {
    case couldntMapCocktails
    case failedToGetCocktails
}

enum CreationErrors: LocalizedError, Equatable {
    case emptyCocktailFields(Focus)
    case emptyMeasuresFields
    
    var errorDescription: String? {
        switch self {
        case .emptyCocktailFields:
            "Some fields are missing!"
        case .emptyMeasuresFields:
            "Some ingredients are missing or doesn't have measures"
        }
    }
}

