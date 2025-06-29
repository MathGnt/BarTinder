//
//  Home.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI
import SwiftData

struct Home: View {
    
    @State private var viewModel = PatchBay.patch.makeCocktailViewModel()
    @State private var cocktail = Cocktail(isPossible: true)
    
    @Binding var finishSwiping: Bool
    @Binding var hasFetched: Bool
    @Namespace private var namespace
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(CocktailFilterPredicate.allCases, id: \.self) { filter in
                                SortingScrollView(title: filter.rawValue, filterOption: filter)
                            }
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
                    
                    HorizontalScrollView(summer: true)
                    
                    sectionTitle(title: "Winter Ideas Ingredients")
                    
                    HorizontalScrollView(summer: false)
                    
                    Spacer()
                }
                .navigationDestination(item: $viewModel.selectedIngredient) { ingredient in
                    CocktailList(ingredientCard: ingredient, viewModel: viewModel)
                }
                .navigationTitle("Home")
                .toolbar {
                    HomeToolbar(
                        finishSwiping: $finishSwiping,
                        sortOption: $viewModel.sortOption,
                        hasFetched: $hasFetched,
                        namespace: namespace,
                    )
                }
                .sheet(isPresented: $viewModel.showCreationSheet) {
                    NavigationStack {
                        CreateEditCocktail(cocktail: cocktail)
                            .navigationTransition(.zoom(sourceID: "ingredients-sheet", in: namespace))
                    }
                }
            }
        }
        .environment(viewModel)
    }
}

#Preview(traits: .queryMocks) {
    Home(finishSwiping: .constant(true), hasFetched: .constant(true))
}


//MARK: - Small components

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
