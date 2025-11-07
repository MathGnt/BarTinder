/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A toolbar component that provides save and cancel actions for cocktail creation.
*/

import SwiftUI
import SwiftData

extension CreateEditCocktail {
    struct CreationToolbar: ToolbarContent {
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
    @Environment(Router.self) private var router
    @Environment(CocktailCreationModel.self) private var model
    @Environment(\.modelContext) private var context
    @FocusState.Binding var focus: Focus?
    let cocktail: Cocktail
    
    var body: some ToolbarContent {
        @Bindable var model = model
        
        ToolbarItem(placement: .confirmationAction) {
            Button("Done", systemImage: "checkmark") {
                do {
                    try model.checkAndInsertCocktail(cocktail)
                    try? context.save()
                    router.popToAllRoots()
                } catch CreationErrors.emptyCocktailFields(let field) {
                    model.missingFocus = field
                    model.generalCocktailFieldsMissing = true
                } catch CreationErrors.emptyMeasuresFields {
                    model.generalCocktailFieldsMissing = true
                } catch {
                    print("Unknown error \(error)")
                }
            }
            .alert("Missing fields", isPresented: $model.generalCocktailFieldsMissing) {
                Button("Fill field", role: .confirm) {
                    focus = model.missingFocus
                    if cocktail.ingredients.isEmpty {
                        router.presentSheet(.ingredientsEdit(cocktail))
                    }
                    
                }
            } message: {
                Text("Some fields are missing!")
            }
        }
    }
}

private struct CancelCocktailButton: ToolbarContent {
    @Environment(CocktailCreationModel.self) private var model
    @Environment(CocktailModel.self) private var cocktailModel
    @Environment(Router.self) private var router
    @Bindable var cocktail: Cocktail
    
    var body: some ToolbarContent {
        @Bindable var model = model
        
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                model.askForDiscard = true
            }
            .tint(.red)
            .confirmationDialog("Discard Changes", isPresented: $model.askForDiscard) {
                Button("Discard Changes", systemImage: "checkmark") {
                    if router.sheetPaths.count > 1 {
                        router.popToAllRoots()
                    } else {
                        router.dismissSheet()
                    }
                }
            } message: {
                Text("Do you want to discard changes?")
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
            .environment(CocktailCreationModel())
            .environment(Router())
            .environment(CocktailModel())
    }
}

