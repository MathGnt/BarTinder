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
    @Namespace private var sheetTransition
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
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
                        
                        
                        Button {
                            viewModel.showNewIdeaSheet = true
                        } label: {
                            GetInspiredCard()
                                .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                        
                        sectionTitle(title: "Summer Ideas Ingredients")
                        IngredientGrid()
                            .padding(.horizontal)
                            .padding(.bottom, BarTinderApp.Padding.scrollViewVerticalSpacing)
                        
                        Spacer()
                    }
                    .navigationTitle("Home")
                    .toolbar {
                        HomeToolbar(
                            sortOption: $viewModel.sortOption,
                            namespace: sheetTransition,
                        )
                    }
                    .sheet(isPresented: $viewModel.showCreationSheet) {
                        NavigationStack {
                            CreateEditCocktail(cocktail: cocktail)
                                .navigationTransition(.zoom(sourceID: "ingredients-sheet", in: sheetTransition))
                                .onDisappear {
                                    self.cocktail = Cocktail(isPossible: true)
                                }
                        }
                    }
                }
                if viewModel.showNewIdeaSheet {
                    DescribeYourCocktail(showNewIdeaSheet: $viewModel.showNewIdeaSheet, namespace: namespace)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 50))
                        .padding(.bottom, 5)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .zIndex(1)
                        .matchedTransitionSource(id: ("get-inspired"), in: namespace)
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0), value: viewModel.showNewIdeaSheet)
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
        .padding(.top, BarTinderApp.Padding.bigTitleSpacingTop)
        .padding(.bottom, title == "Your Cocktails" ? BarTinderApp.Padding.titleSpacingBottom : BarTinderApp.Padding.bigTitleSpacingBottom)
    }
}
