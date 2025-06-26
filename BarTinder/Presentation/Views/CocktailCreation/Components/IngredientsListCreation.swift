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
    @Bindable var cocktail: Cocktail
    @FocusState.Binding var focus: Focus?
    
    var body: some View {
        List {
            Section("Added") {
                ForEach(cocktail.ingredients) { ingredient in
                    HStack(spacing: 15) {
                        IngredientRow(focus: $focus, ingredient: ingredient, viewModel: viewModel)
                    }
                }
                .onDelete { IndexSet in
                    viewModel.removeIngredient(indexSet: IndexSet, cocktail)
                }
            }
            Section("All Ingredients") {
                ForEach(viewModel.searchableIngredients) { ingredient in
                    HStack(spacing: 15) {
                        AllIngredients(cocktail: cocktail, ingredient: ingredient, viewModel: viewModel)
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchableField, prompt: "Search for an ingredient")
        .toolbar {
            doneButton(viewModel: viewModel)
            KeyboardReturnButton(focus: $focus)
        }
    }
}

#Preview {
    @Previewable @FocusState var focus: Focus?
    IngredientsListCreation(viewModel: PatchBay.patch.makeCocktailCreationViewModel(), cocktail: Cocktail.mocks, focus: $focus)
}

//MARK: - VIEW FUNCTIONS

private extension IngredientsListCreation {
    
    struct AllIngredients: View {
        let cocktail: Cocktail
        let ingredient: CardIngredient
        let viewModel: CocktailCreationViewModel
        
        var body: some View {
            HStack {
                Image(ingredient.name.logolized())
                    .resizable()
                    .scaledToFill()
                    .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                Text(ingredient.name.capitalizedWords)
                    .fontWeight(.medium)
                
                Spacer()
                
                Button {
                    viewModel.addIngredient(cocktail, ingredient)
                } label: {
                    Image(systemName: cocktail.ingredients.contains(where: { $0.name == ingredient.name }) ? "checkmark.circle.fill" : "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(cocktail.ingredients.contains(where: { $0.name == ingredient.name }) ? .green : .turborider)
                }
                .buttonStyle(.borderless)
            }
        }
    }
    
    struct IngredientRow: View {
        
        @FocusState.Binding var focus: Focus?
        @Bindable var ingredient: Ingredient
        let viewModel: CocktailCreationViewModel
        var body: some View {
            VStack(spacing: 15) {
                HStack {
                    Image(ingredient.name.logolized())
                        .resizable()
                        .scaledToFill()
                        .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(ingredient.name.capitalizedWords)
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                if ingredient.unit != .topUp && ingredient.unit != .toRinse {
                    HStack {
                        Text("Measure:")
                        Spacer()
                        
                        TextField(viewModel.textFieldPlaceholder(ingredient.unit), text: $ingredient.measure)
                            .focused($focus, equals: .measure)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                }
                
                Picker("Unit", selection: $ingredient.unit) {
                    ForEach(Units.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .onChange(of: ingredient.unit) { _, newValue in
                    viewModel.removeMeasure(ingredient, newValue)
                }
            }
        }
    }
    
    private func doneButton(viewModel: CocktailCreationViewModel) -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button {
                do {
                    try viewModel.checkAndInsertIngredients(cocktail.ingredients)
                    dismiss()
                } catch {
                    viewModel.measuresFieldMissing = true
                }
            } label: {
                Text("Done")
            }
            .alert("Missing fields", isPresented: $viewModel.measuresFieldMissing) {

            } message: {
                Text(CreationErrors.emptyMeasuresFields.localizedDescription)
            }
        }
    }
}
