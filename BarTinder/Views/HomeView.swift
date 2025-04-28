//
//  HomeView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var pushToBar = false
    @State var isSelected: Bool
    @State private var viewModel = HomeViewModel()
    @State private var selectedIngredient: IngredientCard?
    @Bindable var swipeViewModel: SwipeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    HStack {
                        Button("Your Cocktails") {
                            withAnimation(.smooth) {
                                swipeViewModel.selectedCategory = .possibleCocktails
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 130, height: 30)
                        .background(swipeViewModel.selectedCategory == .possibleCocktails ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 5)
                        .scaleEffect(swipeViewModel.selectedCategory == .possibleCocktails ? 1.05 : 1)
                        Button("Gin") {
                            withAnimation(.smooth) {
                                swipeViewModel.selectedCategory = .gin
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 30)
                        .background(swipeViewModel.selectedCategory == .gin ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 5)
                        .scaleEffect(swipeViewModel.selectedCategory == .gin ? 1.05 : 1)
                        Button("Vodka") {
                            withAnimation(.smooth) {
                                swipeViewModel.selectedCategory = .vodka
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 70, height: 30)
                        .background(swipeViewModel.selectedCategory == .vodka ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 5)
                        .scaleEffect(swipeViewModel.selectedCategory == .vodka ? 1.05 : 1)
                        Button("Vermouth") {
                            withAnimation(.smooth) {
                                swipeViewModel.selectedCategory = .vermouth
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 30)
                        .background(swipeViewModel.selectedCategory == .vermouth ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 5)
                        .scaleEffect(swipeViewModel.selectedCategory == .vermouth ? 1.05 : 1)
                        Button("Whisky") {
                            withAnimation(.smooth) {
                                swipeViewModel.selectedCategory = .whisky
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 30)
                        .background(swipeViewModel.selectedCategory == .whisky ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 5)
                        .scaleEffect(swipeViewModel.selectedCategory == .whisky ? 1.05 : 1)
                        Button("Short Drinks") {
                            withAnimation(.smooth) {
                                swipeViewModel.selectedCategory = .shortDrink
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 110, height: 30)
                        .background(swipeViewModel.selectedCategory == .shortDrink ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 5)
                        .scaleEffect(swipeViewModel.selectedCategory == .shortDrink ? 1.05 : 1)
                        Button("Long Drinks") {
                            withAnimation(.smooth) {
                                swipeViewModel.selectedCategory = .longDrink
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 110, height: 30)
                        .background(swipeViewModel.selectedCategory == .longDrink ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.bottom, 5)
                        .scaleEffect(swipeViewModel.selectedCategory == .longDrink ? 1.05 : 1)
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
            .navigationDestination(item: $selectedIngredient) { ingredient in
              CocktailListView(ingredientCard: ingredient, viewModel: swipeViewModel)
            }
            .navigationDestination(isPresented: $pushToBar, destination: {
                BarView()
            })
            .task {
                swipeViewModel.getCocktails()
                swipeViewModel.mockPossibleCocktails()
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
}

#Preview {
    HomeView(isSelected: false, swipeViewModel: SwipeViewModel(repo: CocktailRepo(networkManager: NetworkManager())))
}
