//
//  CreationToolbar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/06/2025.
//

import SwiftUI

extension CreateEditCocktail {
    
    struct CreationToolbar: ToolbarContent {
        @Environment(CreationViewModel.self) private var viewModel
        @FocusState.Binding var focus: Focus?
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            CreateCocktailButton(focus: $focus, cocktail: cocktail)
            CancelCocktailButton(cocktail: cocktail)
            KeyboardReturnButton(focus: $focus)
        }
    }
    
}

private struct CreateCocktailButton: ToolbarContent {
    @Environment(CreationViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState.Binding var focus: Focus?
    let cocktail: Cocktail
    
    var body: some ToolbarContent {
        @Bindable var viewModel = viewModel
        
        ToolbarItem(placement: .confirmationAction) {
            Button {
                do {
                    try viewModel.checkAndInsertCocktail(cocktail)
                    dismiss()
                } catch CreationErrors.emptyCocktailFields(let field) {
                    viewModel.missingFocus = field
                    
                    viewModel.generalCocktailFieldsMissing = true
                } catch {
                    print("Unknown error")
                }
                
            } label: {
                Text("Done")
                    .foregroundStyle(.validate)
            }
            .alert("Missing fields", isPresented: $viewModel.generalCocktailFieldsMissing) {
                Button("Cancel", role: .cancel) {}
                
                Button("Fill field", role: .confirm) {
                    focus = viewModel.missingFocus
                    if viewModel.missingFocus == .measure {
                        viewModel.showIngredientsSheet = true
                    }
                }
                
            } message: {
                Text("Some fields are missing!")
            }
        }
    }
}

private struct CancelCocktailButton: ToolbarContent {
    @Environment(CreationViewModel.self) private var viewModel
    @Environment(\.swiftData) private var swiftData
    @Environment(\.dismiss) private var dismiss
    
    let cocktail: Cocktail
    
    var body: some ToolbarContent {
        @Bindable var viewModel = viewModel
        
        ToolbarItem(placement: .cancellationAction) {
            Button {
                viewModel.askForDiscard = true
            } label: {
                Text("Cancel")
                    .foregroundStyle(.applered)
            }
            .confirmationDialog("Discard Changes", isPresented: $viewModel.askForDiscard) {
                Button("Discard Changes", role: .destructive) {
                    dismiss()
                }
            } message: {
                Text(swiftData.getContextContent(Cocktail.self).contains(cocktail) ? "Are you sure you want to discard changes?" : "Are you sure you want to discard this new cocktail?")
            }
        }
    }
}




#Preview {
    @Previewable @FocusState var focus: Focus?
    NavigationStack {
        Text("Creation Toolbar")
            .toolbar {
                CreateEditCocktail.CreationToolbar(focus: $focus, cocktail: Cocktail.ginto)
            }
            .environment(PatchBay.patch.makeCreationViewModel())
    }
}

