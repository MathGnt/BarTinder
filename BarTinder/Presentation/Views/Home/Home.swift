//
//  Home.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI
import SwiftData

/// The main view of the app.
struct Home: View {
    @State private var viewModel = PatchBay.patch.makeCocktailViewModel()
    @State private var cocktail = Cocktail(isPossible: true)
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
                        .padding(.horizontal)
                        .padding(.bottom, BarTinderApp.Padding.scrollViewVerticalSpacing)
                    sectionTitle(title: "Get inspired")
                    sectionTitle(title: "Summer Ideas Ingredients")
                    HorizontalScrollView(summer: true)
                        .padding(.horizontal)
                        .padding(.bottom, BarTinderApp.Padding.scrollViewVerticalSpacing)
                    Spacer()
                }
                .navigationDestination(item: $viewModel.selectedIngredient) { ingredient in
                    IngredientMatches(ingredientCard: ingredient)
                }
                .navigationTitle("Home")
                .toolbar {
                    HomeToolbar(
                        sortOption: $viewModel.sortOption,
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
    Home()
        .environment(Storage())
}


//MARK: - Small components

private extension Home {
    private func sectionTitle(title: String) -> some View {
        HStack {
            Text(title)
            Spacer()
        }
        .font(.system(size: 22, weight: .semibold, design: .rounded))
        .padding(.horizontal)
        .padding(.top, title == "Your Cocktails" ? BarTinderApp.Padding.titleSpacingTop : BarTinderApp.Padding.bigTitleSpacingTop)
        .padding(.bottom, title == "Your Cocktails" ? BarTinderApp.Padding.titleSpacingBottom : BarTinderApp.Padding.bigTitleSpacingBottom)
     
    }
}
