//
//  HomeView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var pushToBar = false
    @State private var viewModel = HomeViewModel()
    @State private var selectedIngredient: IngredientCard?
    @State private var selectedCocktail: Cocktail?
    @Bindable var swipeViewModel: SwipeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    HStack {
                        scrollBar(title: "Your Cocktails", selectedCategory: .possibleCocktails, width: 130, height: 30)
                        scrollBar(title: "Gin", selectedCategory: .gin, width: 50, height: 30)
                        scrollBar(title: "Vodka", selectedCategory: .vodka, width: 70, height: 30)
                        scrollBar(title: "Vermouth", selectedCategory: .vermouth, width: 100, height: 30)
                        scrollBar(title: "Whisky", selectedCategory: .whisky, width: 80, height: 30)
                        scrollBar(title: "Short Drinks", selectedCategory: .shortDrink, width: 110, height: 30)
                        scrollBar(title: "Long Drinks", selectedCategory: .longDrink, width: 110, height: 30)
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .scrollIndicators(.hidden)
                
                HStack {
                    Text("Your Cocktails")
                    Spacer()
                }
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .padding(.horizontal, 18)
                .padding(.top, 10)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(swipeViewModel.sortedCocktails) { cocktail in
                            Image(cocktail.image)
                                .resizable()
                                .frame(width: 150, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .onTapGesture {
                                    selectedCocktail = cocktail
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(18)
                HStack {
                    Text("Summer Ideas Ingredients")
                    Spacer()
                }
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .padding(.horizontal, 18)
                .padding(.top, 10)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(IngredientCard.ingredientCards.filter { $0.summer == true }, id: \.self) { ingredient in
                            Image(ingredient.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .onTapGesture {
                                    selectedIngredient = ingredient
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(18)
                
                Spacer()
            }
            .navigationDestination(item: $selectedCocktail) { cocktail in
                CocktailDetailView(cocktail: cocktail, viewModel: swipeViewModel)
            }
            .navigationDestination(item: $selectedIngredient) { ingredient in
                CocktailListView(ingredientCard: ingredient, viewModel: swipeViewModel)
            }
            .navigationDestination(isPresented: $pushToBar) {
                BarView()
            }
            .task {
                swipeViewModel.getCocktails()
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem {
                    Button {
                        pushToBar = true
                    } label: {
                        Image(systemName: "wineglass")
                            .foregroundStyle(.limegreen)
                    }
                }
            }
        }
        
    }
    
    private func scrollBar(title: String, selectedCategory: Category, width: CGFloat, height: CGFloat) -> some View {
        Button(title) {
            withAnimation(.smooth) {
                swipeViewModel.selectedCategory = selectedCategory
            }
        }
        .foregroundStyle(.white)
        .frame(width: width, height: height)
        .background(swipeViewModel.selectedCategory == selectedCategory ? .applered : .gray.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.bottom, 5)
        .scaleEffect(swipeViewModel.selectedCategory == selectedCategory ? 1.05 : 1)
    }
}

#Preview {
    HomeView(swipeViewModel: SwipeViewModel(repo: CocktailRepo(networkManager: NetworkManager())))
}
