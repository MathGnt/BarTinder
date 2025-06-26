//
//  Home.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI
import SwiftData

struct Home: View {
    
    @Environment(SwipeViewModel.self) private var swipeViewModel
    @State private var viewModel = PatchBay.patch.makeCocktailViewModel()
    @Binding var finishSwiping: Bool
    @Binding var hasFetched: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ScrollView(.horizontal) {
                        HStack {
                            menuScrollBar
                        }
                        .buttonStyle(.plain)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .scrollIndicators(.hidden)
                    
                    sectionTitle(title: "Your Cocktails")
                    
                    YourCocktailsScrollView(viewModel: viewModel)
                        .scrollIndicators(.hidden)
                        .contentMargins(18)
                    
                    sectionTitle(title: "Summer Ideas Ingredients")
                    
                    HorizontalScrollBar(viewModel: viewModel, summer: true)
                    
                    sectionTitle(title: "Winter Ideas Ingredients")
                    
                    HorizontalScrollBar(viewModel: viewModel, summer: false)
                    
                    Spacer()
                }
                .navigationDestination(item: $viewModel.selectedIngredient) { ingredient in
                    CocktailList(ingredientCard: ingredient, viewModel: viewModel)
                }
                .navigationTitle("Home")
                .toolbar {
                    HomeToolbar(
                        viewModel: $viewModel,
                        finishSwiping: $finishSwiping,
                        sortOption: $viewModel.sortOption,
                        hasFetched: $hasFetched
                    )
                }
              
            }
        }
    }
}

#Preview(traits: .queryMocks) {
    Home(finishSwiping: .constant(true), hasFetched: .constant(true))
        .environment(PatchBay.patch.makeSwipeViewModel())
}


//MARK: - VIEW PROPERTIES AND FUNCTIONS

private extension Home {
    
    private func sectionTitle(title: String) -> some View {
        HStack {
            Text(title)
            Spacer()
        }
        .font(.system(size: 22, weight: .semibold, design: .rounded))
        .padding(.horizontal, 18)
        .padding(.top, 10)
    }
}

//MARK: Scrollviews

extension Home {
    
    @ViewBuilder
    private var menuScrollBar: some View {
        
        SortingScrollView(viewModel: viewModel, title: "Your Cocktails", filterOption: .possibleCocktails, width: 130, height: 30)
        SortingScrollView(viewModel: viewModel, title: "Gin", filterOption: .gin, width: 50, height: 30)
        SortingScrollView(viewModel: viewModel, title: "Vodka", filterOption: .vodka, width: 70, height: 30)
        SortingScrollView(viewModel: viewModel, title: "Vermouth", filterOption: .vermouth, width: 100, height: 30)
        SortingScrollView(viewModel: viewModel, title: "Whisky", filterOption: .whisky, width: 80, height: 30)
        SortingScrollView(viewModel: viewModel, title: "Short Drinks", filterOption: .shortDrink, width: 110, height: 30)
        SortingScrollView(viewModel: viewModel, title: "Long Drinks", filterOption: .longDrink, width: 110, height: 30)
    }
}
