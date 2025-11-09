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
    @Bindable var cocktail: Cocktail

    var body: some View {
        List {
            Section {
                CocktailPreviewSection(selectedImage: $model.selectedPic, cocktail: cocktail)
            }
            Section {
                NameUITextField(text: $cocktail.name)
                DescriptionTextField(text: $cocktail.cocktailDescription)
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
            CreationToolbar(cocktail: cocktail)
        }
        .navigationTitle(cocktail.isNew ? "Edit Cocktail" : "New Cocktail")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .environment(model)
    }
}


#Preview(traits: .barTinderEnvironments) {
    NavigationStack {
        CreateEditCocktail(cocktail: Cocktail.ginto)
    }
}





