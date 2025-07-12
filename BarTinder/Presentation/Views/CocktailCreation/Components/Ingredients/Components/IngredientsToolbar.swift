//
//  IngredientsToolbar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 27/06/2025.
//

import Foundation
import SwiftUI

extension IngredientsListCreation {
    /// The toolbar to validate the cocktail's ingredients - cancel or done.
    struct IngredientsToolbar: ToolbarContent {
        @Environment(\.dismiss) private var dismiss
        @Bindable var model: CreationModel
        @FocusState.Binding var focus: Focus?
        
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", role: .confirm) {
                    do {
                        try model.checkForIngredients(cocktail.ingredients)
                        dismiss()
                    } catch {
                        model.measuresFieldMissing = true
                    }
                }
                .alert("Missing fields", isPresented: $model.measuresFieldMissing) {
                    
                } message: {
                    Text(CreationErrors.emptyMeasuresFields.localizedDescription)
                }
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                    cocktail.ingredients = model.currentIngredientsState
                }
            }
            KeyboardReturnButton(focus: $focus)
        }
    }
}

#Preview {
    @Previewable @FocusState var focus: Focus?
    NavigationStack {
        Text("IngredientsToolbar")
            .toolbar {
                IngredientsListCreation.IngredientsToolbar(model: PatchBay.patch.makeCreationModel(), focus: $focus, cocktail: Cocktail.ginto)
            }
    }
}
