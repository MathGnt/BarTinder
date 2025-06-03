//
//  Home.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI
import SwiftData

struct Home: View {
    
    let swipeViewModel: SwipeViewModel
    @State private var viewModel = PatchBay.patch.makeCocktailViewModel()
    @Binding var finishSwiping: Bool
    
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
                    
                    YourCocktailsScrollView(viewModel: viewModel, swipeViewModel: swipeViewModel, sortOption: viewModel.sortOption, filterOption: viewModel.filterOption)
                        .scrollIndicators(.hidden)
                        .contentMargins(18)
                    
                    sectionTitle(title: "Summer Ideas Ingredients")
                    
                    horizontalScrollBar(viewModel: viewModel, true)
                    
                    sectionTitle(title: "Winter Ideas Ingredients")
                    
                    horizontalScrollBar(viewModel: viewModel, false)
                    
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
                        sortOption: $viewModel.sortOption
                    )
                }
            }
        }
        .tint(.turborider)
    }
}

#Preview(traits: .queryMocks) {
    Home(swipeViewModel: PatchBay.patch.makeSwipeViewModel(), finishSwiping: .constant(true))
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
    
    func horizontalScrollBar(viewModel: CocktailViewModel, _ summer: Bool) -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Ingredient.ingredientCards.filter { $0.summer == summer }, id: \.self) { ingredient in
                    Image(ingredient.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .onTapGesture {
                            viewModel.selectedIngredient = ingredient
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(18)
    }
}
