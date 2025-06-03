//
//  CocktailList.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/04/2025.
//

import SwiftUI
import SwiftData

struct CocktailList: View {
    
    let ingredientCard: Ingredient
    let viewModel: CocktailViewModel
    @State private var selectedCocktail: Cocktail?
    
    @Query private var cocktails: [Cocktail]
    
    init(ingredientCard: Ingredient, viewModel: CocktailViewModel) {
        self.ingredientCard = ingredientCard
        self.viewModel = viewModel
        _cocktails = Query(filter: CocktailFilterCategory.byIngredient(ingredientCard))
    }

    var body: some View {
        List(cocktails) { cocktail in
            HStack(spacing: 15) {
                cocktail.displayedImage
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
            .contentShape(Rectangle())
            .onTapGesture {
                selectedCocktail = cocktail
            }
        }
        .navigationTitle(ingredientCard.name.capitalizedWords)
        .navigationDestination(item: $selectedCocktail) { cocktail in
            CocktailDetail(cocktail: cocktail)
        }
    }
}

#Preview {
    CocktailList(ingredientCard: Ingredient.mocks, viewModel: PatchBay.patch.makeCocktailViewModel())
}
