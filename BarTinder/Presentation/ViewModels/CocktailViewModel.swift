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
    
    var selectedIngredient: Ingredient?
    var filterOption: CocktailFilterPredicate = .possibleCocktails
    var isReversed: Bool = false
    var sortOption: CocktailSortDescriptor = .name
    var resetConfirmation = false
    var showCreationSheet = false

    
    var yourCocktailsDescriptor: FetchDescriptor<Cocktail> {
        FetchDescriptor(predicate: filterOption.filterPredicate, sortBy: sortOption.sortDescriptor(reversed: isReversed))
    }
}
