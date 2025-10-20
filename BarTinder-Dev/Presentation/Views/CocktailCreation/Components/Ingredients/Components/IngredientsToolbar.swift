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
        @Environment(\.swiftData) private var swiftData
        @Bindable var model: CreationModel
        @FocusState.Binding var focus: Focus?
        
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", systemImage: "checkmark") {
                    do {
                        try model.checkForIngredients(cocktail.ingredients)
                        dismiss()
                        print("the current cockctail is \(cocktail)")
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
                Button("Cancel", systemImage: "xmark") {
                    dismiss()
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
