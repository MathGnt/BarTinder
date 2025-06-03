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
        barButton
        resetButton(viewModel)
        createNewCocktailButton(viewModel)
        sortingButton
    }
}

private extension HomeToolbar {
    
    private var barButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink(destination: Bar(viewModel: viewModel)) {
                Image(systemName: "wineglass")
                    .foregroundStyle(.turborider)
            }
        }
    }
    
    private func resetButton(_ viewModel: CocktailViewModel) -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.resetConfirmation = true
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .foregroundStyle(.turborider)
            }
            .alert("Are you sure you want to reset back to swiping cards?", isPresented: $viewModel.resetConfirmation) {
                Button("Reset") {
                    dataBase.contextDeleteAll(Cocktail.self)
                    finishSwiping = false
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    private func createNewCocktailButton(_ viewModel: CocktailViewModel) -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            createNewCocktailButton
                .sheet(isPresented: $viewModel.showCreationSheet) {
                    NavigationStack {
                        CreateCocktail()
                    }
                }
        }
    }
    
    private var sortingButton: some ToolbarContent {
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
            .tint(.turborider)
        }
        
    }
    
    private var createNewCocktailButton: some View {
        Button {
            viewModel.showCreationSheet = true
        } label: {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.turborider)
                Text("Create yours")
                    .foregroundStyle(.turborider)
            }
            .padding(2)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
