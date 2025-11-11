/*
See the LICENSE file for this project's licensing information.

Abstract:
An enum that handles all the navigation cases for any sheet.
*/

import Foundation
import SwiftUI

enum SheetDestination: Hashable, Identifiable {
    case cocktailDetail(Cocktail)
    case cocktailEdit(Cocktail)
    case ingredientsEdit(Cocktail)
    case askedForCocktail
    
    var id: Int { hashValue }
}

