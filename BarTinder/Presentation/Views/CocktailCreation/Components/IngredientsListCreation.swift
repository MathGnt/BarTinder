//
//  IngredientsListCreation.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI
import SwiftData

struct IngredientsListCreation: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: CocktailCreationViewModel
    
    var body: some View {
        List {
            Section("Added") {
                ForEach(viewModel.addedIngredients) { ingredient in
                    addedIngredientDisplayer(ingredient)
                }
                .onDelete { indices in
                    viewModel.removeIngredient(indices: indices)
                }
            }
            Section("All Ingredients") {
                ForEach(viewModel.searchableIngredients) { ingredient in
                    HStack(spacing: 15) {
                        allIngredientDisplayer(ingredient)
                    }
                    
                }
            }
        }
        .searchable(text: $viewModel.searchableField, prompt: "Search for an ingredient")
        .toolbar {
            doneButton(viewModel: viewModel)
        }
    }
}

#Preview {
    IngredientsListCreation(viewModel: PatchBay.patch.makeCocktailCreationViewModel())
}
    
//MARK: - VIEW FUNCTIONS

private extension IngredientsListCreation {
    
    @ViewBuilder
    func addedIngredientDisplayer(_ ingredient: Ingredient) -> some View {
        HStack(spacing: 15) {
            ingredientRow(ingredient: ingredient)
        }
        
        if viewModel.haveToEnterMeasure(for: ingredient) {
            TextField(viewModel.textFieldPlaceholder(for: ingredient.id), text: $viewModel.cocktailMeasure[ingredientMeasure: ingredient.id])
            .keyboardType(.decimalPad)
        }
        Picker("Unit", selection: $viewModel.selectedUnit[ingredientUnit: ingredient.id]) {
            ForEach(Units.allCases) { unit in
                Text(unit.rawValue).tag(unit)
            }
        }
    }
    
    @ViewBuilder
    private func allIngredientDisplayer(_ ingredient: Ingredient) -> some View {
        ingredientRow(ingredient: ingredient)
        
        Button {
            viewModel.addIngredient(ingredient: ingredient)
        } label: {
            Image(systemName: viewModel.addedIngredients.contains(ingredient) ? "checkmark.circle.fill" : "plus.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(viewModel.addedIngredients.contains(ingredient) ? .green : .turborider)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
    
    private func ingredientRow(ingredient: Ingredient) -> some View {
        HStack(spacing: 15) {
            Image(ingredient.name.logolized())
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(ingredient.name.capitalizedWords)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func doneButton(viewModel: CocktailCreationViewModel) -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button {
                viewModel.createIngredientsMeasures()
                if !viewModel.ingredientsNotValid {
                    dismiss()
                }
            } label: {
                Text("Done")
            }
            .alert("Missing fields", isPresented: $viewModel.ingredientsNotValid) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text("Please enter measures for each ingredients")
            }
        }
    }
}

/// Extension for bindings - no need to deal with 'transaction' bug
extension Dictionary where Key == String, Value == String {
    subscript(ingredientMeasure id: String) -> String {
        get { self[id] ?? "" }
        set { self[id] = newValue }
    }
}

extension Dictionary where Key == String, Value == Units {
    subscript(ingredientUnit id: String) -> Units {
        get { self[id] ?? .cl }
        set { self[id] = newValue }
    }
}


