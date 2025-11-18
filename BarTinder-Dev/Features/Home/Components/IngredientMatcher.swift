/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view that displays all cocktails that can be made with a selected ingredient.
*/

import SwiftUI
import SwiftData

struct IngredientMatcher: View {
    @Query private var cocktails: [Cocktail]
    let ingredientCard: CardIngredient

    init(ingredientCard: CardIngredient) {
        self.ingredientCard = ingredientCard
        _cocktails = Query(filter: CocktailFilterPredicate.byIngredient(ingredientCard))
    }
    
    var body: some View {
        CocktailList(cocktails: cocktails)
            .navigationTitle(ingredientCard.name.capitalized)
    }
}

#Preview(traits: .queryMocks, .modelsEnvironment) {
    IngredientMatcher(ingredientCard: CardIngredient.ingredientCards[5])
}
