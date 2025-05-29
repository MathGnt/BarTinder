//
//  HomeView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var context
    @State private var viewModel = PatchBay.patch.makeHomeViewModel()
    @Namespace private var namespace
    @Binding var finishSwiping: Bool
    
    @Query(filter: Cocktail.isPossiblePredicate()) var possibleCocktails: [Cocktail]
    let swipeViewModel: SwipeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ScrollView(.horizontal) {
                        HStack {
                            scrollBar
                        }
                        .buttonStyle(.plain)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .scrollIndicators(.hidden)
                    
                    sectionTitle(title: "Your Cocktails")
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.sortQuery(from: possibleCocktails)) { cocktail in
                                NavigationLink {
                                    CocktailDetailView(cocktail: cocktail)
                                        .navigationTransition(.zoom(sourceID: cocktail.id, in: namespace))
                                } label: {
                                    cocktailImageSource(cocktail: cocktail)
                                        .matchedTransitionSource(id: cocktail.id, in: namespace)
                                }
                            }
                            
                        }
                    }
                    .scrollIndicators(.hidden)
                    .contentMargins(18)
                    
                    sectionTitle(title: "Summer Ideas Ingredients")
                    
                    horizontalScrollBar(viewModel: viewModel, true)
                    
                    sectionTitle(title: "Winter Ideas Ingredients")
                    
                    horizontalScrollBar(viewModel: viewModel, false)
                    
                    Spacer()
                }
                .navigationDestination(item: $viewModel.selectedIngredient) { ingredient in
                    CocktailListView(ingredientCard: ingredient, swipeViewModel: swipeViewModel)
                }
                .navigationTitle("Home")
                .toolbar {
                    HomeViewToolBarCpn(viewModel: $viewModel, finishSwiping: $finishSwiping)
                }
            }
        }
    }
}

#Preview {
    HomeView(finishSwiping: .constant(true), swipeViewModel: PatchBay.patch.makeSwipeViewModel())
}


//MARK: - VIEW PROPERTIES AND FUNCTIONS

//MARK: Image and Title

extension HomeView {
    
    private func cocktailImageSource(cocktail: Cocktail) -> some View {
        cocktail.displayedImage?
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .contentShape(
                .contextMenuPreview,
                RoundedRectangle(cornerRadius: 20)
            )
            .contextMenu {
                Button("Delete", role: .destructive) {
                    withAnimation {
                        viewModel.deleteCocktail(cocktail, context)
                    }
                }
            }
    }
    
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

extension HomeView {
    
    @ViewBuilder
    private var scrollBar: some View {
        ScrollBarItemCpn(viewModel: viewModel, title: "Your Cocktails", selectedCategory: .possibleCocktails, width: 130, height: 30)
        ScrollBarItemCpn(viewModel: viewModel, title: "Gin", selectedCategory: .gin, width: 50, height: 30)
        ScrollBarItemCpn(viewModel: viewModel, title: "Vodka", selectedCategory: .vodka, width: 70, height: 30)
        ScrollBarItemCpn(viewModel: viewModel, title: "Vermouth", selectedCategory: .vermouth, width: 100, height: 30)
        ScrollBarItemCpn(viewModel: viewModel, title: "Whisky", selectedCategory: .whisky, width: 80, height: 30)
        ScrollBarItemCpn(viewModel: viewModel, title: "Short Drinks", selectedCategory: .shortDrink, width: 110, height: 30)
        ScrollBarItemCpn(viewModel: viewModel, title: "Long Drinks", selectedCategory: .longDrink, width: 110, height: 30)
    }
    
    func horizontalScrollBar(viewModel: HomeViewModel, _ summer: Bool) -> some View {
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
