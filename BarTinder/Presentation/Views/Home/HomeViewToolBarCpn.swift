//
//  HomeViewToolBarCpn.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI
import SwiftData

struct HomeViewToolBarCpn: ToolbarContent {
    
    @Environment(\.swiftData) private var dataBase
    @Binding var viewModel: CocktailViewModel
    @Binding var finishSwiping: Bool
    
    var body: some ToolbarContent {
        barButton
        resetButton(viewModel: viewModel)
        createNewCocktailButton(viewModel: viewModel)
    }
}

extension HomeViewToolBarCpn {
    
    private var barButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink(destination: BarView(viewModel: viewModel)) {
                Image(systemName: "wineglass")
                    .foregroundStyle(.turborider)
            }
        }
    }
    
    private func resetButton(viewModel: CocktailViewModel) -> some ToolbarContent {
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
    
    private func createNewCocktailButton(viewModel: CocktailViewModel) -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            createNewCocktailButton
                .sheet(isPresented: $viewModel.showCreationSheet) {
                    NavigationStack {
                        CocktailCreationView()
                    }
                }
        }
    }
    
    private var createNewCocktailButton: some View {
        Button {
            viewModel.showCreationSheet = true
        } label: {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.turborider)
                Text("Create Your Own")
                    .foregroundStyle(.turborider)
            }
            .padding(2)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
