/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI toolbar component to save or cancel the selected ingredients.
*/

import Foundation
import SwiftUI

extension IngredientsListCreation {
    struct IngredientsToolbar: ToolbarContent {
        @Environment(Router.self) private var router
        @Bindable var model: IngredientCreationModel
        
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", systemImage: "checkmark") {
                    do {
                        try model.checkForIngredients(cocktail.ingredients)
                        router.goBack()
                    } catch {
                        model.measuresFieldMissing = true
                    }
                }
                .alert("Missing fields", isPresented: $model.measuresFieldMissing) {
                
                } message: {
                    Text(CreationErrors.emptyMeasuresFields.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    @Previewable @FocusState var focus: Focus?
    NavigationStack {
        Text("IngredientsToolbar")
            .toolbar {
                IngredientsListCreation.IngredientsToolbar(model: IngredientCreationModel(), cocktail: Cocktail.ginto)
            }
            .environment(Router())
    }
}
