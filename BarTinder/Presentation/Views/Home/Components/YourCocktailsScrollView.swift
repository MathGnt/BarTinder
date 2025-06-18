//
//  YourCocktailsScrollView.swift
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
    @Environment(\.swiftData) private var dataBase
    
    @Query private var cocktails: [Cocktail]
    
    init(
        viewModel: CocktailViewModel,
        swipeViewModel: SwipeViewModel,
    ) {
        self.viewModel = viewModel
        self.swipeViewModel = swipeViewModel
        
        // Dynamic filtering & sorting
        _cocktails = Query(viewModel.yourCocktailsDescriptor)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
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
                Button {
                    
                } label: {
                    Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                
                Button(role: .destructive) {
                    withAnimation {
                        if cocktail.stock {
                            cocktail.isPossible = false
                        } else {
                            dataBase.contextDelete(cocktail)
                        }
                    }
                    swipeViewModel.removeSelectedIngredients()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .animation(.easeInOut, value: cocktail)
            }
    }
}
