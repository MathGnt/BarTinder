//
//  CocktailCreation.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateCocktail: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = PatchBay.patch.makeCocktailCreationViewModel()
    @FocusState private var focus: Focus?
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 15) {
                    CocktailImagePicker(viewModel: viewModel, selectedImage: $viewModel.selectedPic)
                    
                    Text(viewModel.cocktailName)
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                }
            }
            
            Section {
                nameDescriptionFields()
            }
            
            Section {
                NavigationLink {
                    IngredientsListCreation(viewModel: viewModel)
                } label: {
                    Text("Ingredients")
                }
                ForEach(viewModel.addedIngredients) { ingredient in
                    Text(ingredient.name.capitalizedWords)
                }
            }
            
            Section {
                
                abvFlavorFields()
            }
            
            Section {
                PickersOptions(viewModel: viewModel)
            }
            
        }
        .navigationTitle("New Cocktail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            CreationToolbar(viewModel: viewModel, notValid: $viewModel.notValid, focus: $focus)
        }
    }
    
}

#Preview {
    CreateCocktail()
}

private extension CreateCocktail {
    
    @ViewBuilder
    private func nameDescriptionFields() -> some View {
        TextField("Name", text: $viewModel.cocktailName)
            .characterLimit(30, text: $viewModel.cocktailName)
            .focused($focus, equals: .name)
            .submitLabel(.next)
            .onSubmit {
                focus = .description
            }
        
        TextField("Description", text: $viewModel.cocktailDescription, axis: .vertical)
            .lineLimit(5, reservesSpace: true)
            .focused($focus, equals: .description)
            .submitLabel(.done)
            .onSubmit {
                focus = .ABV
            }
    }
    
    @ViewBuilder
    private func abvFlavorFields() -> some View {
        TextField("ABV", text: $viewModel.cocktailAbv)
            .focused($focus, equals: .ABV)
            .keyboardType(.numberPad)
            .submitLabel(.next)
            .onSubmit {
                focus = .flavor
            }
        
        TextField("Flavor", text: $viewModel.cocktailFlavor)
            .characterLimit(15, text: $viewModel.cocktailFlavor)
            .focused($focus, equals: .flavor)
            .submitLabel(.next)
            .onSubmit {
                focus = nil
            }
    }
}

enum Focus {
    case name
    case description
    case ABV
    case flavor
}

