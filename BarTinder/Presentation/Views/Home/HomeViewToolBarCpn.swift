//
//  HomeViewToolBarCpn.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI
import SwiftData

struct HomeViewToolBarCpn: ToolbarContent {
    @Binding var viewModel: HomeViewModel
    @Environment(\.modelContext) private var context
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
            NavigationLink(destination: BarView()) {
                Image(systemName: "wineglass")
                    .foregroundStyle(.turborider)
            }
        }
    }
    
    private func resetButton(viewModel: HomeViewModel) -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.resetConfirmation = true
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .foregroundStyle(.turborider)
            }
            .alert("Are you sure you want to reset back to swiping cards?", isPresented: $viewModel.resetConfirmation) {
                Button("Reset") {
                    do {
                        try context.deleteAll(Cocktail.self)
                        finishSwiping = false
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    private func createNewCocktailButton(viewModel: HomeViewModel) -> some ToolbarContent {
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
