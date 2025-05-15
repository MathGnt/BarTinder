//
//  VMErrors.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import Foundation

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
