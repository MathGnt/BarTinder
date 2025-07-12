//
//  CreationToolbar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/06/2025.
//

import SwiftUI

extension CreateEditCocktail {
    /// The toolbar to create the cocktail - cancel or create.
    struct CreationToolbar: ToolbarContent {
        @Environment(CreationModel.self) private var model
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
    @Environment(CreationModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @FocusState.Binding var focus: Focus?
    
    let cocktail: Cocktail
    
    var body: some ToolbarContent {
        @Bindable var model = model
        
        ToolbarItem(placement: .confirmationAction) {
            Button {
                do {
                    try model.checkAndInsertCocktail(cocktail)
                    dismiss()
                } catch CreationErrors.emptyCocktailFields(let field) {
                    model.missingFocus = field
                    model.generalCocktailFieldsMissing = true
                } catch {
                    print("Unknown error")
                }
                
            } label: {
                Text("Done")
                    .foregroundStyle(.validate)
            }
            .alert("Missing fields", isPresented: $model.generalCocktailFieldsMissing) {
                Button("Fill field", role: .confirm) {
                    focus = model.missingFocus
                    if model.missingFocus == .measure {
                        model.showIngredientsSheet = true
                    }
                }
                
            } message: {
                Text("Some fields are missing!")
            }
        }
    }
}

private struct CancelCocktailButton: ToolbarContent {
    @Environment(CreationModel.self) private var model
    @Environment(\.swiftData) private var swiftData
    @Environment(\.dismiss) private var dismiss
    
    let cocktail: Cocktail
    
    var body: some ToolbarContent {
        @Bindable var model = model
        
        ToolbarItem(placement: .cancellationAction) {
            Button {
                model.askForDiscard = true
            } label: {
                Text("Cancel")
                    .foregroundStyle(.applered)
            }
            .confirmationDialog("Discard Changes", isPresented: $model.askForDiscard) {
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
            .environment(PatchBay.patch.makeCreationModel())
    }
}

