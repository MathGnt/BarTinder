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
    @Binding var notValid: Bool
    @FocusState.Binding var focus: Focus?
    
    var body: some ToolbarContent {
        createCocktailButton
        cancelButton
        keyboardReturnButton
    }
}

private extension CreationToolbar {
    
    private var createCocktailButton: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button {
                viewModel.createCocktail()
                if !viewModel.notValid {
                    dismiss()
                }
            } label: {
                Text("Done")
            }
            .alert("Missing fields", isPresented: $notValid) {
                
            } message: {
                Text("You didn't complete all the fields!")
            }
        }
    }
    
    private var cancelButton: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
        }
    }
    
    private var keyboardReturnButton: some ToolbarContent {
        ToolbarItem(placement: .keyboard) {
            HStack {
                Spacer()
                Button("Return") {
                    focus = nil
                }
            }
        }
    }
}
