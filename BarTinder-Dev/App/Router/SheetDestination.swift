/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An enum that handles all the navigation cases for any sheet.
*/

import Foundation
import SwiftData

enum SheetDestination: Hashable, Identifiable {
    case cocktailDetail(Cocktail)
    case cocktailEdit(Cocktail)
    case ingredientsEdit(Cocktail)
    case askedForCocktail
    
    var id: Int { hashValue }
}
