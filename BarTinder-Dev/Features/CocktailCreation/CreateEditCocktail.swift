/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view that provides a sheet interface for creating or editing cocktails.
*/

import SwiftUI
import SwiftData
import PhotosUI

struct CreateEditCocktail: View {
    @Environment(Router.self) private var router
    @State private var model = CocktailCreationModel()
    @FocusState private var focus: Focus?
    @Bindable var cocktail: Cocktail
    
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
                    router.presentSheet(.ingredientsEdit(cocktail))
                } label: {
                    SelectYourIngredientsLabel(cocktail: cocktail)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)
                
                ForEach(cocktail.ingredients) { ingredient in
                    ingredientPreviewer(ingredient)
                }
            }
            
            Section {
                PickersOptions(cocktail: cocktail)
            }
        }
        .toolbar {
            CreationToolbar(focus: $focus, cocktail: cocktail)
        }
        .navigationTitle(cocktail.isNew ? "Edit Cocktail" : "New Cocktail")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .environment(model)
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
    @Previewable @FocusState var focus: Focus?
    CreateEditCocktail(cocktail: Cocktail.ginto)
        .environment(Router())
}





