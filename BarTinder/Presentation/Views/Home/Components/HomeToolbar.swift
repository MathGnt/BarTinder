//
//  HomeViewToolBar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI
import SwiftData

struct HomeToolbar: ToolbarContent {
    
    @Environment(\.swiftData) private var dataBase
    @Binding var viewModel: CocktailViewModel
    @Binding var finishSwiping: Bool
    @Binding var sortOption: CocktailSortDescriptor
    @Binding var hasFetched: Bool
    
    @State private var cocktail = Cocktail(isPossible: true)
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            createNewCocktailButton
                .sheet(isPresented: $viewModel.showCreationSheet) {
                    NavigationStack {
                        CreateEditCocktail(cocktail: cocktail)
                    }
                }
        }
        
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
            .alert("Are you sure you want to reset back to swiping cards?", isPresented: $viewModel.resetConfirmation) {
                Button("Reset", role: .destructive) {
                    hasFetched = false
                    dataBase.contextDeleteAll(Cocktail.self)
                    finishSwiping = false
                }
            }
        }
        
    }
}

private extension HomeToolbar {
    
    private var createNewCocktailButton: some View {
        Button {
            cocktail = Cocktail(isPossible: true)
            viewModel.showCreationSheet = true
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.primary)
        }
        .buttonStyle(.plain)
    }
}
