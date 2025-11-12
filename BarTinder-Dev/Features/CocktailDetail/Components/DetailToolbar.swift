/*
See the LICENSE file for this project's licensing information.

Abstract:
A toolbar component that provides actions for editing, deleting, and managing cocktails.
*/

import SwiftUI

extension CocktailDetail {
    struct DetailToolbar: ToolbarContent {
        @Environment(\.router) private var router
        @Environment(\.modelContext) private var context
        @State private var askForDelete = false
        let isGeneratedCocktail: Bool
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            switch isGeneratedCocktail {
            case false:
                ToolbarItem {
                    Menu("Options", systemImage: "ellipsis") {
                        Section {
                            ControlGroup {
                                Button("Edit", systemImage: "rectangle.and.pencil.and.ellipsis") {
                                    router.presentSheet(.cocktailEdit(cocktail))
                                }
                                .disabled(cocktail.stock)
                                
                                Button("Delete", systemImage: "trash", role: .destructive) {
                                    askForDelete = true
                                }
                            }
                        }
                        Section {
                            Button {
                                cocktail.isInBar.toggle()
                            } label: {
                                Label(cocktail.isInBar ? "Remove from bar" : "Add to bar", systemImage: cocktail.isInBar ? "wineglass.fill" : "wineglass")
                                    .foregroundStyle(cocktail.isInBar ? .primary : Color(.green))
                            }
                        }
                    }
                    .confirmationDialog("Delete", isPresented: $askForDelete) {
                        Button("Delete") {
                            context.contextDelete(cocktail)
                            try? context.save()
                            router.goBack()
                        }
                
                    } message: {
                        Text("Are you sure you want to delete this cocktail?")
                    }
                }
                
            case true:
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark") {
                        try? context.save()
                        router.popToAllRoots()
                    }
                }
                ToolbarItem {
                    Button("Edit", systemImage: "pencil") {
                        router.presentSheet(.cocktailEdit(cocktail))
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        router.popToAllRoots()
                    }
                }
            }
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    NavigationStack {
        Text("Detail Toolbar")
            .toolbar {
                CocktailDetail.DetailToolbar(isGeneratedCocktail: false, cocktail: Cocktail.ginto)
            }
    }
}
