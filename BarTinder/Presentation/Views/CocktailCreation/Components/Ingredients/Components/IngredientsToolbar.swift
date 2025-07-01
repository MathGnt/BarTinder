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
        @Bindable var viewModel: CreationViewModel
        @FocusState.Binding var focus: Focus?
        
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", role: .confirm) {
                    do {
                        try viewModel.checkForIngredients(cocktail.ingredients)
                        dismiss()
                    } catch {
                        viewModel.measuresFieldMissing = true
                    }
                }
                .alert("Missing fields", isPresented: $viewModel.measuresFieldMissing) {
                    
                } message: {
                    Text(CreationErrors.emptyMeasuresFields.localizedDescription)
                }
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                    cocktail.ingredients = viewModel.currentIngredientsState
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
                IngredientsListCreation.IngredientsToolbar(viewModel: PatchBay.patch.makeCreationViewModel(), focus: $focus, cocktail: Cocktail.ginto)
            }
    }
}
