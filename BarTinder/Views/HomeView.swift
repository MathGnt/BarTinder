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
    @State private var viewModel = HomeViewModel()
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
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(Ingredient.ingredientCards.filter { $0.summer == true }, id: \.self) { ingredient in
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
                    
                    sectionTitle(title: "Winter Ideas Ingredients")
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(Ingredient.ingredientCards.filter { $0.summer == false }, id: \.self) { ingredient in
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
                    
                    Spacer()
                }
                .navigationDestination(item: $viewModel.selectedIngredient) { ingredient in
                    CocktailListView(ingredientCard: ingredient, viewModel: swipeViewModel)
                }
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: BarView()) {
                            Image(systemName: "wineglass")
                                .foregroundStyle(.turborider)
                        }
                    }
                    
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
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            Button("Canclel", role: .cancel) { }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        createNewCocktailButton
                            .sheet(isPresented: $viewModel.showCreationSheet) {
                                NavigationStack {
                                    CocktailCreationView()
                                }
                            }
                    }
                }
            }
        }
    }
    
    //MARK: - View Properties and Functions
    
    @ViewBuilder
    private var scrollBar: some View {
        scrollBarItem(title: "Your Cocktails", selectedCategory: .possibleCocktails, width: 130, height: 30)
        scrollBarItem(title: "Gin", selectedCategory: .gin, width: 50, height: 30)
        scrollBarItem(title: "Vodka", selectedCategory: .vodka, width: 70, height: 30)
        scrollBarItem(title: "Vermouth", selectedCategory: .vermouth, width: 100, height: 30)
        scrollBarItem(title: "Whisky", selectedCategory: .whisky, width: 80, height: 30)
        scrollBarItem(title: "Short Drinks", selectedCategory: .shortDrink, width: 110, height: 30)
        scrollBarItem(title: "Long Drinks", selectedCategory: .longDrink, width: 110, height: 30)
    }
    
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
                    context.delete(cocktail)
                    try? context.save()
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
    
    private func scrollBarItem(title: String, selectedCategory: Category, width: CGFloat, height: CGFloat) -> some View {
        Button(title) {
            withAnimation(.smooth) {
                viewModel.selectedCategory = selectedCategory
            }
        }
        .foregroundStyle(.white)
        .frame(width: width, height: height)
        .background(viewModel.selectedCategory == selectedCategory ? .applered : .gray.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.bottom, 5)
        .scaleEffect(viewModel.selectedCategory == selectedCategory ? 1.05 : 1)
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

#Preview {
    HomeView(finishSwiping: .constant(true), swipeViewModel: SwipeViewModel(repo: CocktailRepo(networkManager: NetworkManager())))
}
