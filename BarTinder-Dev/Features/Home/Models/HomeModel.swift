/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An observable model that manages cocktail filtering, sorting, and display options.
*/

import Foundation
import SwiftData
import Observation

@Observable
final class CocktailModel {
    var filterOption: CocktailFilterPredicate = .possibleCocktails
    var sortOption: CocktailSortDescriptor = .name
    var isReversed: Bool = false
    var resetConfirmation = false
    var showNewIdeaSheet = false
    var askForDelete = false
    
    var cocktail = Cocktail(isPossible: true)

    var yourCocktailsDescriptor: FetchDescriptor<Cocktail> {
        FetchDescriptor(predicate: filterOption.filterPredicate, sortBy: sortOption.sortDescriptor(reversed: isReversed))
    }
}
