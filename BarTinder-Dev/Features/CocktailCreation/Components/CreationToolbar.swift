/*
 See the LICENSE file for this project's licensing information.
 
 Abstract:
 A toolbar component that provides save and cancel actions for cocktail creation.
 */

import SwiftUI
import SwiftData

extension CreateEditCocktail {
    struct CreationToolbar: ToolbarContent {
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            CreateCocktailButton(cocktail: cocktail)
            CancelCocktailButton(cocktail: cocktail)
        }
    }
}

extension CreateEditCocktail.CreationToolbar {
    struct CreateCocktailButton: ToolbarContent {
        @Environment(\.router) private var router
        @Environment(CocktailCreationModel.self) private var model
        @Environment(\.modelContext) private var context
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            @Bindable var model = model
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", systemImage: "checkmark") {
                    do {
                        try model.checkAndInsertCocktail(cocktail)
                        try? context.save()
                        router.creationDismiss()
                    } catch CreationErrors.emptyCocktailFields, CreationErrors.emptyMeasuresFields {
                        model.generalCocktailFieldsMissing = true
                    } catch {
                        print("Unknown error \(error)")
                    }
                }
                .alert("Missing fields", isPresented: $model.generalCocktailFieldsMissing) {
                    Button("Fill field", role: .confirm) {
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
    
    
    struct CancelCocktailButton: ToolbarContent {
        @Environment(CocktailCreationModel.self) private var model
        @Environment(HomeModel.self) private var cocktailModel
        @Environment(\.router) private var router
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
                        router.creationDismiss()
                    }
                } message: {
                    Text("Do you want to discard changes?")
                }
            }
        }
    }
}

#Preview(traits: .modelsEnvironment) {
    NavigationStack {
        Text("Creation Toolbar")
            .toolbar {
                CreateEditCocktail.CreationToolbar(cocktail: Cocktail.ginto)
            }
    }
}
