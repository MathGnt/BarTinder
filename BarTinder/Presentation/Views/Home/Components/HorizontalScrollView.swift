//
//  HorizontalScrollView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/06/2025.
//

import SwiftUI

extension Home {
    /// A scrollview of ingredients depending of the season.
    struct HorizontalScrollView: View {
        @Environment(CocktailViewModel.self) private var viewModel
        
        let summer: Bool
        let rows = [
            GridItem(.flexible(), spacing: BarTinderApp.Padding.scrollViewSpacing),
            GridItem(.flexible(), spacing: BarTinderApp.Padding.scrollViewSpacing)
        ]
        
        var body: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: BarTinderApp.Padding.scrollViewSpacing) {
                    ForEach(CardIngredient.ingredientCards.filter { $0.summer == summer }, id: \.self) { ingredient in
                        Image(ingredient.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .onTapGesture {
                                viewModel.selectedIngredient = ingredient
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    Home.HorizontalScrollView(summer: true)
        .environment(PatchBay.patch.makeCocktailViewModel())
}
