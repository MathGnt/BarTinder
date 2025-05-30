//
//  Errors.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import Foundation


enum NetworkErrors: LocalizedError {
    case couldntFetchCocktails
    
    var errorDescription: String? {
        switch self {
        case .couldntFetchCocktails:
            return "Couldn't fetch cocktails list"
        }
    }
}

enum SwiftDataErrors: Error {
    case failedToDeleteDataBase
}

enum CUCErrors: Error {
    case emptyFields
}

enum RepoErrors: Error {
    case failedToFetchSorted
}

enum VMErrors: LocalizedError {
    
    case couldntFetchCocktails
    case failedFetchDescriptor(any Error)
    
    var errorDescription: String? {
        switch self {
        case .couldntFetchCocktails:
            return "Couldn't fetch cocktails in the VM from the repo"
        case .failedFetchDescriptor(let error):
            return "Error fetching cocktails: \(error)"
        }
    }
}
