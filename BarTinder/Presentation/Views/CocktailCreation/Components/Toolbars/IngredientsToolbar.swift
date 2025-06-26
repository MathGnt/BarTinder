//
//  IngredientsToolbar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 27/06/2025.
//

import Foundation
import SwiftUI

extension IngredientsListCreation {
    
    struct IngredientsToolbar: ToolbarContent {
        @Environment(\.dismiss) private var dismiss
        @Bindable var viewModel: CocktailCreationViewModel
        @FocusState.Binding var focus: Focus?
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", role: .confirm) {
                    do {
                        try viewModel.checkAndInsertIngredients(cocktail.ingredients)
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
                    cocktail.ingredients = []
                    dismiss()
                }
            }
            KeyboardReturnButton(focus: $focus)
        }
    }
    
}
