//
//  CreateEditCocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI
import SwiftData
import PhotosUI

extension EnvironmentValues {
    @Entry var draftContext: ModelContext?
}

/// A sheet allowing the user to create or edit his own cocktail.
struct CreateEditCocktail: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.swiftData) private var swiftData
    @State private var model = PatchBay.patch.makeCreationModel()
    @FocusState private var focus: Focus?
    @Bindable var cocktail: Cocktail
    
    var draftContext: ModelContext
    
    init(cocktailID: PersistentIdentifier? = nil, newCocktail: Cocktail? = nil, in container: ModelContainer) {
        if let cocktailID {
            // Edition - PersistentID.temporary = false
            draftContext = ModelContext(container)
            draftContext.autosaveEnabled = false
            cocktail = draftContext.model(for: cocktailID) as? Cocktail ?? Cocktail()
        } else {
            // Création - PersistentID.temporary = true
            draftContext = container.mainContext
            cocktail = newCocktail ?? Cocktail()
        }
    }
    
    
    var body: some View {
        List {
            Section {
                CocktailPreviewHeader(selectedImage: $model.selectedPic, cocktail: cocktail)
            }
            
            Section {
                CocktailTextField(focus: $focus, title: "Name", binding: $cocktail.name, axis: .horizontal, config: CreationTextFieldConfig.name)
                CocktailTextField(focus: $focus, title: "Description", binding: $cocktail.cocktailDescription, axis: .vertical, config: CreationTextFieldConfig.description)
                    .lineLimit(5, reservesSpace: true)
            }
            
            Section {
                Button {
                    model.showIngredientsSheet = true
//                    model.currentIngredientsState = cocktail.ingredients
                } label: {
                    SelectYourIngredientsLabel(cocktail: cocktail)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)
                
                ForEach(cocktail.ingredients) { ingredient in
                    ingredientPreviewer(ingredient)
                }
                .onDelete { IndexSet in
                    model.removeIngredient(indexSet: IndexSet, cocktail)
                }
            }
            
            Section {
                PickersOptions(cocktail: cocktail)
            }
            
        }
        .navigationTitle(swiftData.getContextContent(Cocktail.self).contains(cocktail) ? "Edit Cocktail" : "New Cocktail")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            CreationToolbar(focus: $focus, cocktail: cocktail)
        }
        .environment(\.draftContext, draftContext)
        .environment(model)
        .sheet(isPresented: $model.showIngredientsSheet) {
            NavigationStack {
                IngredientsListCreation(cocktail: cocktail, focus: $focus)
                    .interactiveDismissDisabled()
                    .environment(model)
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
    CreateEditCocktail(cocktailID: Cocktail.ginto.persistentModelID, newCocktail: Cocktail(), in: try! ModelContainer(
        for: Cocktail.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    ))
}





