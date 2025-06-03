//
//  CocktailScrollView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/06/2025.
//

import SwiftUI
import SwiftData

struct YourCocktailsScrollView: View {
    
    let viewModel: CocktailViewModel
    let swipeViewModel: SwipeViewModel
    @Namespace private var namespace
    
    @Query private var cocktails: [Cocktail]
    
    init(
        viewModel: CocktailViewModel,
        swipeViewModel: SwipeViewModel,
        sortOption: CocktailSortOption,
        filterOption: CocktailFilterCategory
    ) {
        self.viewModel = viewModel
        self.swipeViewModel = swipeViewModel
        
        // Dynamic filtering & sorting
        _cocktails = Query(filter: filterOption.filterCategory,
                           sort: sortOption.sortDescriptors)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(cocktails) { cocktail in
                    NavigationLink {
                        CocktailDetail(cocktail: cocktail)
                            .navigationTransition(.zoom(sourceID: cocktail.id, in: namespace))
                    } label: {
                        cocktailImageSource(cocktail)
                            .matchedTransitionSource(id: cocktail.id, in: namespace)
                    }
                }
                
            }
        }
    }
}


private extension YourCocktailsScrollView {
    
    private func cocktailImageSource(_ cocktail: Cocktail) -> some View {
        cocktail.displayedImage
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
                    viewModel.deleteCocktail(cocktail)
                    swipeViewModel.removeSelectedIngredients()
                }
                .animation(.easeInOut, value: cocktail)
            }
    }
}
