//
//  IngredientMatches.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/04/2025.
//

import SwiftUI
import SwiftData

struct IngredientMatches: View {
    
    let ingredientCard: CardIngredient
    
    @Query private var cocktails: [Cocktail]
    
    init(ingredientCard: CardIngredient) {
        self.ingredientCard = ingredientCard
        
        _cocktails = Query(filter: CocktailFilterPredicate.byIngredient(ingredientCard))
    }
    
    var body: some View {
        CocktailList(cocktails: cocktails)
            .navigationTitle(ingredientCard.name.capitalizedWords)
        
    }
}

#Preview {
    IngredientMatches(ingredientCard: CardIngredient.mocks)
}
