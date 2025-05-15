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
    @Query(filter: Cocktail.isPossiblePredicate()) var possibleCocktails: [Cocktail]
    @Bindable var swipeViewModel: SwipeViewModel
    @State private var viewModel = HomeViewModel()
    
    @Binding var finishSwiping: Bool
    
    var body: some View {
        NavigationStack {
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
                            cocktail.displayedImage?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .onTapGesture {
                                    viewModel.selectedCocktail = cocktail
                                }
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
                        .animation(.easeInOut, value: possibleCocktails)
                        
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
                                .aspectRatio(contentMode: .fill)
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
            .navigationDestination(item: $viewModel.selectedCocktail) { cocktail in
                CocktailDetailView(cocktail: cocktail)
            }
            .navigationDestination(item: $viewModel.selectedIngredient) { ingredient in
                CocktailListView(ingredientCard: ingredient, viewModel: swipeViewModel)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: BarView()) {
                        Image(systemName: "wineglass")
                            .foregroundStyle(.limegreen)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.resetConfirmation = true
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
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
                    Button {
                        viewModel.showCreationSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.limegreen)
                         Text("Create Your Own")
                                .foregroundStyle(.limegreen)
                        }
                        .padding(2)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $viewModel.showCreationSheet) {
                        NavigationStack {
                            CocktailCreationView()
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
    HomeView(swipeViewModel: SwipeViewModel(repo: CocktailRepo(networkManager: NetworkManager())), finishSwiping: .constant(true))
}
