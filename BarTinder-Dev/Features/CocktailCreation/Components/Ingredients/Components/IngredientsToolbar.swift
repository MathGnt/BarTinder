/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI toolbar component to save or cancel the selected ingredients.
*/

import Foundation
import SwiftUI

extension IngredientsListCreation {
    struct IngredientsToolbar: ToolbarContent {
        @Environment(\.router) private var router
        @Bindable var model: IngredientCreationModel
        
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", systemImage: "checkmark") {
                    do {
                        try model.checkForIngredients(cocktail.ingredients)
                        router.popNavigation()
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

#Preview(traits: .barTinderEnvironments) {
    NavigationStack {
        Text("IngredientsToolbar")
            .toolbar {
                IngredientsListCreation.IngredientsToolbar(model: IngredientCreationModel(), cocktail: Cocktail.ginto)
            }
    }
}
