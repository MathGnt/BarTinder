/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An enumeration defining validation errors that can occur during cocktail creation.
*/

import Foundation

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
