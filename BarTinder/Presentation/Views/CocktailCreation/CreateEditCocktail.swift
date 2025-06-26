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
                HStack(spacing: 15) {
                    CocktailImagePicker(viewModel: viewModel, selectedImage: $viewModel.selectedPic, cocktail: cocktail)
                    
                    Text(cocktail.name)
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                }
            }
            
            Section {
                nameDescriptionFields()
            }
            
            Section {
                NavigationLink {
                    IngredientsListCreation(viewModel: viewModel, cocktail: cocktail, focus: $focus)
                } label: {
                    Text("Ingredients")
                }
                ForEach(cocktail.ingredients) { ingredient in
                    Text(ingredient.name.capitalizedWords)
                }
            }
            
            Section {
                
                abvFlavorFields()
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
    
    @ViewBuilder
    private func nameDescriptionFields() -> some View {
        TextField("Name", text: $cocktail.name)
            .characterLimit(30, text: $cocktail.name)
            .focused($focus, equals: .name)
            .submitLabel(.next)
            .onSubmit {
                focus = .description
            }
        
        TextField("Description", text: $cocktail.cocktailDescription, axis: .vertical)
            .lineLimit(5, reservesSpace: true)
            .focused($focus, equals: .description)
            .submitLabel(.done)
            .onSubmit {
                focus = .ABV
            }
    }
    
    @ViewBuilder
    private func abvFlavorFields() -> some View {
        TextField("ABV", text: $cocktail.abv)
            .focused($focus, equals: .ABV)
            .keyboardType(.numberPad)
            .submitLabel(.next)
            .onSubmit {
                focus = .flavor
            }
        
        TextField("Flavor", text: $cocktail.flavor)
            .characterLimit(15, text: $cocktail.flavor)
            .focused($focus, equals: .flavor)
            .submitLabel(.next)
            .onSubmit {
                focus = nil
            }
    }
}
