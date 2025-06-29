//
//  CreateEditCocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateEditCocktail: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = PatchBay.patch.makeCocktailCreationViewModel()
    @FocusState private var focus: Focus?
    
    @Bindable var cocktail: Cocktail
    
    var body: some View {
        List {
            Section {
                CocktailPreviewHeader(selectedImage: $viewModel.selectedPic, cocktail: cocktail)
            }
            
            Section {
                CocktailTextField(title: "Name", binding: $cocktail.name, axis: .horizontal, config: CreationTextFieldConfig.name, focus: $focus)
                CocktailTextField(title: "Description", binding: $cocktail.cocktailDescription, axis: .vertical, config: CreationTextFieldConfig.description, focus: $focus)
                    .lineLimit(5, reservesSpace: true)
            }
            
            Section {
                Button {
                    viewModel.showIngredientsSheet = true
                    viewModel.currentIngredientsState = cocktail.ingredients
                } label: {
                    SelectYourIngredientsLabel(cocktail: cocktail)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)
                
                ForEach(cocktail.ingredients) { ingredient in
                    ingredientPreviewer(ingredient)
                }
                .onDelete { IndexSet in
                    viewModel.removeIngredient(indexSet: IndexSet, cocktail)
                }
            }
            
            Section {
                CocktailTextField(title: "Abv", binding: $cocktail.abv, axis: .horizontal, config: CreationTextFieldConfig.abv, focus: $focus)
                CocktailTextField(title: "Flavor", binding: $cocktail.flavor, axis: .horizontal, config: CreationTextFieldConfig.flavor, focus: $focus)
            }
            
            Section {
                PickersOptions(cocktail: cocktail)
            }
            
        }
        .navigationTitle("New Cocktail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            CreationToolbar(focus: $focus, cocktail: cocktail)
        }
        .environment(viewModel)
        .sheet(isPresented: $viewModel.showIngredientsSheet) {
            NavigationStack {
                IngredientsListCreation(cocktail: cocktail, focus: $focus)
                    .interactiveDismissDisabled()
                    .environment(viewModel)
            }
        }
    }
    
    private func ingredientPreviewer(_ ingredient: Ingredient) -> some View {
        HStack(spacing: 0) {
            Image(ingredient.name.logolized())
                .resizable()
                .scaledToFill()
                .padding(.trailing, 15)
                .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
            
            Text(ingredient.name.capitalizedWords)
            Spacer()
            Text(ingredient.measure + " " + ingredient.unit.rawValue)
        }
    }
}

#Preview {
    CreateEditCocktail(cocktail: Cocktail.ginto)
}
