//
//  CocktailCreation.swift
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
                CocktailPreviewHeader(viewModel: viewModel, selectedImage: $viewModel.selectedPic, cocktail: cocktail)
            }
            
            Section {
                CocktailTextField(title: "Name", binding: $cocktail.name, axis: .horizontal, config: CreationTextFieldConfig.name, focus: $focus)
                CocktailTextField(title: "Description", binding: $cocktail.cocktailDescription, axis: .vertical, config: CreationTextFieldConfig.description, focus: $focus)
                    .lineLimit(5, reservesSpace: true)
            }
            
            Section {
                Button {
                    viewModel.showIngredientsSheet = true
                } label: {
                    selectYourIngredientsLabel(cocktail)
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $viewModel.showIngredientsSheet) {
                    NavigationStack {
                        IngredientsListCreation(viewModel: viewModel, cocktail: cocktail, focus: $focus)
                            .interactiveDismissDisabled()
                    }
                }
                
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
                PickersOptions(viewModel: viewModel, cocktail: cocktail)
            }
            
        }
        .navigationTitle("New Cocktail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            CreationToolbar(viewModel: viewModel, generalCocktailFieldsMissing: $viewModel.generalCocktailFieldsMissing, focus: $focus, cocktail: cocktail)
        }
    }
    
}

#Preview {
    CreateEditCocktail(cocktail: Cocktail.mocks)
}


private extension CreateEditCocktail {
    
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
    
    private func selectYourIngredientsLabel(_ cocktail: Cocktail) -> some View {
        HStack(spacing: 15) {
            let isEmpty = cocktail.ingredients.isEmpty
            Image(systemName: "flask.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 24, height: 24)
           
                .foregroundStyle(.bartinderclr)
                .overlay {
                    Image(systemName: isEmpty ? "plus.circle.fill" : "minus.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 14, height: 14)
                        .foregroundStyle(isEmpty ? .validate : .applered)
                        .offset(x: 10, y: -5)
                }
            Text(isEmpty ? "Select your ingredients" : "Modify your ingredients")
        }
    }
}
