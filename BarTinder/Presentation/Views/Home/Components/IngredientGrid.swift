//
//  IngredientGrid.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/06/2025.
//

import SwiftUI

extension Home {
    /// A scrollview of ingredients depending of the season.
    struct IngredientGrid: View {
        @Environment(CocktailModel.self) private var model
        @Namespace private var namespace
    
        let rows = [
            GridItem(.flexible(), spacing: BarTinderApp.Padding.scrollViewSpacing),
            GridItem(.flexible(), spacing: BarTinderApp.Padding.scrollViewSpacing)
        ]
        
        var body: some View {
            @Bindable var model = model
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: BarTinderApp.Padding.scrollViewSpacing) {
                    ForEach(CardIngredient.ingredientCards.filter { $0.summer == true }, id: \.self) { ingredient in
                        Image(ingredient.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                            .onTapGesture {
                                model.selectedIngredient = ingredient
                            }
                            .matchedTransitionSource(id: ingredient.id, in: namespace)
                           
                    }
                }
            }
            .scrollIndicators(.hidden)
            .navigationDestination(item: $model.selectedIngredient) { ingredient in
                IngredientMatches(ingredientCard: ingredient)
                    .navigationTransition(.zoom(sourceID: ingredient.id, in: namespace))
                
            }
        }
    }
}

#Preview {
    Home.IngredientGrid()
        .environment(PatchBay.patch.makeCocktailModel())
}
