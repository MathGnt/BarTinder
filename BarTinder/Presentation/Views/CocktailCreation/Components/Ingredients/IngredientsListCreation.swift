//
//  IngredientsListCreation.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI
import SwiftData

/// A sheet allowing the user to select the ingredients for his cocktail.
struct IngredientsListCreation: View {
    @Environment(CreationModel.self) private var model
    @Bindable var cocktail: Cocktail
    @FocusState.Binding var focus: Focus?
    
    var body: some View {
        @Bindable var model = model
        List {
            Section("Added ingredients") {
                ForEach(cocktail.ingredients) { ingredient in
                    HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                        IngredientRow(focus: $focus, ingredient: ingredient, model: model)
                    }
                }
                .onDelete { IndexSet in
                    model.removeIngredient(indexSet: IndexSet, cocktail)
                }
            }
            Section("All Ingredients") {
                ForEach(model.searchableIngredients) { ingredient in
                    HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                        AllIngredients(cocktail: cocktail, ingredient: ingredient, model: model)
                    }
                }
            }
        }
        .searchable(text: $model.searchableField, prompt: "Search for an ingredient")
        .toolbar {
            IngredientsToolbar(model: model, focus: $focus, cocktail: cocktail)
        }
    }
}

#Preview {
    @Previewable @FocusState var focus: Focus?
    IngredientsListCreation(cocktail: Cocktail.ginto, focus: $focus)
        .environment(PatchBay.patch.makeCreationModel())
}
