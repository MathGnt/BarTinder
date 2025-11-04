/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A toolbar component that provides actions for editing, deleting, and managing cocktails.
*/

import SwiftUI

extension CocktailDetail {
    struct DetailToolbar: ToolbarContent {
        @Environment(Router.self) private var router
        @Environment(\.modelContext) private var context
        
        let isGeneratedCocktail: Bool
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            switch isGeneratedCocktail {
            case false:
                ToolbarItem {
                    Menu {
                        Section {
                            ControlGroup {
                                Button("Edit", systemImage: "rectangle.and.pencil.and.ellipsis") {
                                    router.presentSheet(.cocktailEdit(cocktail, context.container))
                                }
                                .disabled(cocktail.stock)
                                
                                Button(role: .destructive) {
                                    context.contextDelete(cocktail)
                                    router.backToAllRoot()
                                    
                                } label: {
                                    Label("Delete", systemImage: "trash")
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
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
                
            case true:
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark") {
                        context.contextInsert(cocktail)
                        router.backToAllRoot()
                    }
                }
                ToolbarItem {
                    Button("Edit", systemImage: "pencil") {
                        router.presentSheet(.cocktailEdit(cocktail, context.container))
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        router.backToAllRoot()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        Text("Detail Toolbar")
            .toolbar {
                CocktailDetail.DetailToolbar(isGeneratedCocktail: false, cocktail: Cocktail.ginto)
            }
            .environment(Router())
    }
}
