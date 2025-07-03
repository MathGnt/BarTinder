//
//  CocktailViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 09/05/2025.
//

import Foundation
import SwiftData
import Observation

@Observable
final class CocktailViewModel {
    var selectedIngredient: CardIngredient?
    var filterOption: CocktailFilterPredicate = .possibleCocktails
    var sortOption: CocktailSortDescriptor = .name
    var isReversed: Bool = false
    var resetConfirmation = false
    var showCreationSheet = false
    var showNewIdeaSheet = false
    var askForDelete = false

    var yourCocktailsDescriptor: FetchDescriptor<Cocktail> {
        FetchDescriptor(predicate: filterOption.filterPredicate, sortBy: sortOption.sortDescriptor(reversed: isReversed))
    }
}
