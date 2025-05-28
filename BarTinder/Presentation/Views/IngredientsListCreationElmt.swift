//
//  IngredientsListCreationElmt.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI
import SwiftData

struct IngredientsListCreationElmt: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: CocktailCreationViewModel
    
    var body: some View {
        List {
            Section("Added") {
                ForEach(viewModel.addedIngredients) { ingredient in
                    HStack(spacing: 15) {
                        addedIngredientDisplayer(ingredient: ingredient)
                        
                    }
                    
                    if viewModel.selectedUnit[ingredient.id] != .topUp && viewModel.selectedUnit[ingredient.id] != .toRinse {
                        TextField(viewModel.textFieldPlaceholder(for: ingredient.id), text: Binding<String>(
                            get: { viewModel.cocktailMeasure[ingredient.id] ?? "" },
                            set: { viewModel.cocktailMeasure[ingredient.id] = $0 }
                        ))
                        .keyboardType(.decimalPad)
                    }
                    Picker("Unit", selection: Binding<CocktailCreationViewModel.Units>(
                        get: { viewModel.selectedUnit[ingredient.id] ?? .cl },
                        set: { viewModel.selectedUnit[ingredient.id] = $0 }
                    )) {
                        ForEach(CocktailCreationViewModel.Units.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                }
                .onDelete { indices in
                    viewModel.removeIngredient(indices: indices)
                }
            }
            Section("All Ingredients") {
                ForEach(viewModel.searchableIngredients) { ingredient in
                    HStack(spacing: 15) {
                        allIngredientDisplayer(ingredient: ingredient)
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
    IngredientsListCreationElmt(viewModel: PatchBay.patch.makeCocktailCreationViewModel())
}
    
    //MARK: - VIEW FUNCTIONS

extension IngredientsListCreationElmt {

    @ViewBuilder
    private func addedIngredientDisplayer(ingredient: Ingredient) -> some View {
        HStack(spacing: 15) {
            baseDesign(ingredient: ingredient)
        }
    }
    
    @ViewBuilder
    private func allIngredientDisplayer(ingredient: Ingredient) -> some View {
        baseDesign(ingredient: ingredient)
        
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
    
    @ViewBuilder
    private func baseDesign(ingredient: Ingredient) -> some View {
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


