//
//  DetailToolbar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/06/2025.
//

import SwiftUI

extension CocktailDetail {
    /// The options available to a cocktail - edit, delete, add to bar.
    struct DetailToolbar: ToolbarContent {
        @Environment(\.dismiss) private var dismiss
        @Environment(\.swiftData) private var swiftData
        
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem {
                Menu {
                    Section {
                        ControlGroup {
                            NavigationLink {
                                CreateEditCocktail(cocktail: cocktail)
                            } label: {
                                Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                            }
                            .disabled(cocktail.stock)
                            
                            Button(role: .destructive) {
                                swiftData.contextDelete(cocktail)
                                dismiss()
                                
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
        }
    }
}

#Preview {
    NavigationStack {
        Text("Detail Toolbar")
            .toolbar {
                CocktailDetail.DetailToolbar(cocktail: Cocktail.ginto)
            }
    }
}
