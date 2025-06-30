//
//  HorizontalScrollView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/06/2025.
//

import SwiftUI

extension Home {
    
    struct HorizontalScrollView: View {
        @Environment(CocktailViewModel.self) private var viewModel
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

#Preview {
    Home.HorizontalScrollView(summer: true)
        .environment(PatchBay.patch.makeCocktailViewModel())
}
