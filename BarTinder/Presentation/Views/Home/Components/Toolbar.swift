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
        @Environment(CocktailModel.self) private var model
        @Environment(\.swiftData) private var swiftData
        @Binding var sortOption: CocktailSortDescriptor
        @Binding var cocktail: Cocktail?
        
        let namespace: Namespace.ID
        
        var body: some ToolbarContent {
            @Bindable var model = model
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    cocktail = Cocktail(isPossible: true)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.primary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Create a cocktail")
                .accessibilityHint("Open the sheet to build your own cocktail")
                
            }
            .matchedTransitionSource(id: "ingredients-sheet", in: namespace)
            
            
            ToolbarItem {
                NavigationLink(destination: Bar()) {
                    Image(systemName: "wineglass")
                        .foregroundStyle(.primary)
                }
                .accessibilityLabel("Navigate to your bar")
            }
            ToolbarItem {
                Menu("Main controls", systemImage: "arrow.up.arrow.down") {
                    Section {
                        Toggle("Reverse order", isOn: $model.isReversed)
                    }
                    Section {
                        Picker("Sort by...", selection: $sortOption) {
                            ForEach(CocktailSortDescriptor.allCases, id: \.self) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
                        .labelsVisibility(.visible)
                        .accessibilityLabel("Sorting and filtering options")
                    }
                }
                .tint(.primary)
            }
            
            ToolbarSpacer(.fixed)
            
            ToolbarItem {
                Button {
                    model.resetConfirmation = true
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundStyle(.applered)
                }
                .accessibilityLabel("Reset the app")
                .alert("Are you sure you want to reset to swiping cards?", isPresented: $model.resetConfirmation) {
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
                Home.HomeToolbar(sortOption: .constant(.glass), cocktail: .constant(Cocktail(isPossible: true)), namespace: namespace)
            }
            .environment(PatchBay.patch.makeCocktailModel())
            .environment(Storage())
    }
}
