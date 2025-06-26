//
//  YourCocktailsScrollView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/06/2025.
//

import SwiftUI
import SwiftData

extension Home {
    
    struct YourCocktailsScrollView: View {
        
        let viewModel: CocktailViewModel
        @Namespace private var namespace
        
        @Query private var cocktails: [Cocktail]
        
        init(viewModel: CocktailViewModel) {
            self.viewModel = viewModel
            
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
                            CocktailImageSource(cocktail: cocktail)
                                .matchedTransitionSource(id: cocktail.id, in: namespace)
                        }
                    }
                    
                }
            }
        }
    }
    
    struct CocktailImageSource: View {
        
        @Environment(SwipeViewModel.self) private var swipeViewModel
        @Environment(\.swiftData) private var dataBase
        let cocktail: Cocktail
        
        var body: some View {
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
                    if !cocktail.stock {
                        NavigationLink {
                            CreateEditCocktail(cocktail: cocktail)
                        } label: {
                            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                        }
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
    
    struct HorizontalScrollBar: View {
        let viewModel: CocktailViewModel
        let summer: Bool
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(CardIngredient.ingredientCards.filter { $0.summer == summer }, id: \.self) { ingredient in
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
}
