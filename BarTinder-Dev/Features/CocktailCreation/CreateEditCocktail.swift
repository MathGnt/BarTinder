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
                CocktailPreviewSection(selectedImage: $model.selectedPic, cocktail: cocktail)
            }
            Section {
                CocktailTextField(focus: $focus, title: "Name", binding: $cocktail.name, axis: .horizontal, config: CreationTextFieldConfig.name)
                CocktailTextField(focus: $focus, title: "Description", binding: $cocktail.cocktailDescription, axis: .vertical, config: CreationTextFieldConfig.description)
                    .lineLimit(5, reservesSpace: true)
            }
            Section {
                IngredientsSection(cocktail: cocktail)
            }
            Section {
                CocktailOptionsSection(cocktail: cocktail)
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
}


#Preview {
    @Previewable @FocusState var focus: Focus?
    NavigationStack {
        CreateEditCocktail(cocktail: Cocktail.ginto)
            .environment(Router())
            .environment(CocktailModel())
    }
}





