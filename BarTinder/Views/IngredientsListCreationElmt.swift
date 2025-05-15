//
//  IngredientsListCreationElmt.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI

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
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    if viewModel.isMeasureValid() {
                        viewModel.createIngredientsMeasures()
                        dismiss()
                    }
                } label: {
                    Text("Done")
                }
                .alert("Please complete all the measure fields", isPresented: $viewModel.isMeasureNotValid) {
                    Button("Cancel", role: .cancel) { }
                }
            }
        }
    }
    
    //MARK: - View Functions
    
    @ViewBuilder
    private func addedIngredientDisplayer(ingredient: Ingredient) -> some View {
        HStack(spacing: 15) {
            baseDesign(ingredient: ingredient)
                .allowsHitTesting(false)
        }
        
    }
    
    @ViewBuilder
    private func allIngredientDisplayer(ingredient: Ingredient) -> some View {
        baseDesign(ingredient: ingredient)
        
        Button {
            viewModel.addIngredient(ingredient: ingredient)
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(viewModel.addedIngredients.contains(ingredient) ? .gray : .limegreen)
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
}

#Preview {
    IngredientsListCreationElmt(viewModel: CocktailCreationViewModel())
}
