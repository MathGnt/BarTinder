//
//  IngredientMatches.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/04/2025.
//

import SwiftUI
import SwiftData

/// A view that shows all cocktails available to make based on the selected ingredient.
struct IngredientMatches: View {
    @Query private var cocktails: [Cocktail]
    
    let ingredientCard: CardIngredient

    init(ingredientCard: CardIngredient) {
        self.ingredientCard = ingredientCard
        
        _cocktails = Query(filter: CocktailFilterPredicate.byIngredient(ingredientCard))
    }
    
    var body: some View {
        CocktailList(cocktails: cocktails)
            .navigationTitle(ingredientCard.name.capitalizedWords)
        
    }
}

#Preview(traits: .queryMocks) {
    IngredientMatches(ingredientCard: CardIngredient.gin)
}
