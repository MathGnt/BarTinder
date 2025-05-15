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
    @Bindable var viewModel: SwipeViewModel
    @Query private var cocktails: [Cocktail]
    
    init(ingredientCard: Ingredient, viewModel: SwipeViewModel) {
        self.ingredientCard = ingredientCard
        self.viewModel = viewModel
        
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
        }
    }
}

#Preview {
    CocktailListView(ingredientCard: Ingredient(image: "gin", name: "Gin", otherName: nil, AVB: "40", location: "UK", summer: true, unit: "Cl"), viewModel: SwipeViewModel(repo: CocktailRepo(networkManager: NetworkManager())))
}
