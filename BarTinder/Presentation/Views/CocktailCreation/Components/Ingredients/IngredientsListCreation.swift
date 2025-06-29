//
//  IngredientsListCreation.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI
import SwiftData

struct IngredientsListCreation: View {

    @Environment(CocktailCreationViewModel.self) private var viewModel
    @Bindable var cocktail: Cocktail
    @FocusState.Binding var focus: Focus?
    
    var body: some View {
        @Bindable var viewModel = viewModel
        List {
            Section("Added ingredients") {
                ForEach(cocktail.ingredients) { ingredient in
                    HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                        IngredientRow(focus: $focus, ingredient: ingredient, viewModel: viewModel)
                    }
                }
                .onDelete { IndexSet in
                    viewModel.removeIngredient(indexSet: IndexSet, cocktail)
                }
            }
            Section("All Ingredients") {
                ForEach(viewModel.searchableIngredients) { ingredient in
                    HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                        AllIngredients(cocktail: cocktail, ingredient: ingredient, viewModel: viewModel)
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchableField, prompt: "Search for an ingredient")
        .toolbar {
            IngredientsToolbar(viewModel: viewModel, focus: $focus, cocktail: cocktail)
        }
    }
}

#Preview {
    @Previewable @FocusState var focus: Focus?
    IngredientsListCreation(cocktail: Cocktail.ginto, focus: $focus)
}
