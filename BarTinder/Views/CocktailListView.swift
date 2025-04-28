//
//  CocktailListView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/04/2025.
//

import SwiftUI

struct CocktailListView: View {
    let ingredientCard: IngredientCard
    @Bindable var viewModel: SwipeViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.cocktails.filter { $0.ingredients.contains(ingredientCard.name) }) { cocktail in
                HStack {
                    Text(cocktail.name)
                }
            }
        }
    }
}

#Preview {
    CocktailListView(ingredientCard: IngredientCard(image: "gin", name: "Gin", AVB: "40", location: "UK", summer: true), viewModel: SwipeViewModel(repo: CocktailRepo(networkManager: NetworkManager())))
}
