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
    @Binding var sortOption: CocktailSortOption
    
    var body: some ToolbarContent {
        
        
        ToolbarItem(placement: .topBarLeading) {
            createNewCocktailButton
                .sheet(isPresented: $viewModel.showCreationSheet) {
                    NavigationStack {
                        CreateCocktail()
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
                Picker("Sort By", selection: $sortOption) {
                    ForEach(CocktailSortOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                            .tag(option)
                    }
                }
                .pickerStyle(.menu)
                .buttonStyle(.plain)
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
            viewModel.showCreationSheet = true
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.primary)
        }
        .buttonStyle(.plain)
    }
}
