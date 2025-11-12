/*
See the LICENSE file for this project's licensing information.

Abstract:
An enum that handles all the navigation cases for classic navigation.
*/
import Foundation
import SwiftUI
import SwiftData

enum RouterDestination: Hashable, Identifiable {
    case cocktailDetail(Cocktail, Namespace.ID?)
    case cocktailList(CardIngredient)
    case generatedCocktail
    case bar

    var id: Int { hashValue }
}
