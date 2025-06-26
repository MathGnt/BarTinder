//
//  CocktailCreationToolBar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/06/2025.
//

import SwiftUI

struct CreationToolbar: ToolbarContent {
    
    let viewModel: CocktailCreationViewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var generalCocktailFieldsMissing: Bool
    @FocusState.Binding var focus: Focus?
    
    let cocktail: Cocktail
    
    var body: some ToolbarContent {
        createCocktailButton
        cancelButton
        KeyboardReturnButton(focus: $focus)
    }
}

private extension CreationToolbar {
    
    private var createCocktailButton: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button {
                do {
                    try viewModel.checkAndInsertCocktail(cocktail)
                    dismiss()
                } catch {
                    viewModel.generalCocktailFieldsMissing = true
                }
                
            } label: {
                Text("Done")
                    .foregroundStyle(.validate)
            }
            .alert("Missing fields", isPresented: $generalCocktailFieldsMissing) {
                
            } message: {
                Text(CreationErrors.emptyCocktailFields.localizedDescription)
            }

        }
    }
    
    private var cancelButton: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .foregroundStyle(.applered)
            }
        }
    }
}





