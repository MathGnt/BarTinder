//
//  Toolbar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI
import SwiftData

extension Home {
    
    struct HomeToolbar: ToolbarContent {
        
        @Environment(CocktailViewModel.self) private var viewModel
        @Environment(\.swiftData) private var swiftData
        @Binding var finishSwiping: Bool
        @Binding var sortOption: CocktailSortDescriptor
        @Binding var hasFetched: Bool
        
        let namespace: Namespace.ID
        
        var body: some ToolbarContent {
            @Bindable var viewModel = viewModel
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.showCreationSheet = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.primary)
                }
                .buttonStyle(.plain)
                
            }
            .matchedTransitionSource(id: "ingredients-sheet", in: namespace)
            
            
            ToolbarItem {
                NavigationLink(destination: Bar()) {
                    Image(systemName: "wineglass")
                        .foregroundStyle(.primary)
                }
            }
            
            ToolbarItem {
                Menu("Sort By", systemImage: "arrow.up.arrow.down") {
                    Section {
                        Toggle("Reverse order", isOn: $viewModel.isReversed)
                    }
                    Section {
                        Picker("Sort By", selection: $sortOption) {
                            ForEach(CocktailSortDescriptor.allCases, id: \.self) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                        .buttonStyle(.plain)
                    }
                }
                .tint(.primary)
            }
            
            ToolbarSpacer(.fixed)
            
            ToolbarItem {
                Button {
                    viewModel.resetConfirmation = true
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundStyle(.applered)
                }
                .alert("Are you sure you want to reset to swiping cards?", isPresented: $viewModel.resetConfirmation) {
                    Button("Reset", role: .destructive) {
                        hasFetched = false
                        swiftData.contextDeleteAll(Cocktail.self)
                        finishSwiping = false
                    }
                }
            }
        }
    }
}
