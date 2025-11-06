/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view that provides a sheet interface for selecting and managing cocktail ingredients.
*/

import SwiftUI
import SwiftData

struct IngredientsListCreation: View {
    @State private var model = IngredientCreationModel()
    let cocktail: Cocktail
    
    var body: some View {
        @Bindable var model = model
        
        List {
            Section("Added ingredients") {
                ForEach(cocktail.ingredients) { ingredient in
                    HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                        IngredientRow(ingredient: ingredient, model: model)
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
        .navigationBarBackButtonHidden()
        .toolbar {
            IngredientsToolbar(model: model, cocktail: cocktail)
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    @Previewable @FocusState var focus: Focus?
    IngredientsListCreation(cocktail: Cocktail.ginto)
        .environment(CocktailCreationModel())
}
