//
//  DetailToolbar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/06/2025.
//

import SwiftUI

extension CocktailDetail {
    
    struct DetailToolbar: ToolbarContent {
        @Environment(\.dismiss) private var dismiss
        @Environment(\.swiftData) private var swiftData
        @Environment(CocktailViewModel.self) private var viewModel
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem {
                Menu {
                    Section {
                        ControlGroup {
                            Button {
                                viewModel.showCreationSheet = true
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
                            Label(cocktail.isInBar ? "Remove from bar" : "Add in bar", systemImage: cocktail.isInBar ? "wineglass.fill" : "wineglass")
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
