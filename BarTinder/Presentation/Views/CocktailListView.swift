//
//  CocktailListView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/04/2025.
//

import SwiftUI
import SwiftData

struct CocktailListView: View {
    
    let ingredientCard: Ingredient
    let swipeViewModel: SwipeViewModel
    @Query private var cocktails: [Cocktail]
    @State private var selectedCocktail: Cocktail?
    
    init(ingredientCard: Ingredient, swipeViewModel: SwipeViewModel) {
        self.ingredientCard = ingredientCard
        self.swipeViewModel = swipeViewModel
        
        _cocktails = Query(filter: Cocktail.cocktailAboutIngredient(ingredient: ingredientCard))
    }
    
    var body: some View {
        List(cocktails) { cocktail in
            HStack(spacing: 15) {
                cocktail.displayedImage?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(.circle)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(cocktail.name)
                        .fontWeight(.semibold)
                    Text(cocktail.flavor.capitalized)
                        .font(.callout)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(cocktail.glass)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
            }
            .onTapGesture {
                selectedCocktail = cocktail
            }
        }
        .navigationTitle(ingredientCard.name.capitalizedWords)
        .navigationDestination(item: $selectedCocktail) { cocktail in
            CocktailDetailView(cocktail: cocktail)
        }
    }
}

#Preview {
    CocktailListView(ingredientCard: Ingredient.mocks, swipeViewModel: PatchBay.patch.makeSwipeViewModel())
}
