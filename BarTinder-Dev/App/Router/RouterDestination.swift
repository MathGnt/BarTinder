/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An enum that handles all the navigation cases for classic navigation.
*/
import Foundation
import SwiftUI

enum RouterDestination: Hashable, Identifiable {
    case cocktailDetail(Cocktail, Namespace.ID?)
    case cocktailList(CardIngredient)
    case generatedCocktail
    case bar

    var id: Int { hashValue }
}

