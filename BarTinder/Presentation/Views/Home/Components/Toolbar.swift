//
//  Toolbar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI
import SwiftData

extension Home {
    /// The main toolbar of the app - create  a cocktail, navigate to bar,  select your filters or reset the app.
    struct HomeToolbar: ToolbarContent {
        @Environment(Storage.self) private var appStorage
        @Environment(CocktailViewModel.self) private var viewModel
        @Environment(\.swiftData) private var swiftData
        @Binding var sortOption: CocktailSortDescriptor
        
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
                        Picker("Sort by...", selection: $sortOption) {
                            ForEach(CocktailSortDescriptor.allCases, id: \.self) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
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
                        appStorage.hasFetched = false
                        swiftData.contextDeleteAll(Cocktail.self)
                        appStorage.hasFinshedSwiping = false
                    }
                }
            }
        }
    }
}


#Preview {
    @Previewable @Namespace var namespace
    NavigationStack {
        Text("Home Toolbar")
            .toolbar {
                Home.HomeToolbar(sortOption: .constant(.glass), namespace: namespace)
            }
            .environment(PatchBay.patch.makeCocktailViewModel())
            .environment(Storage())
    }
}
