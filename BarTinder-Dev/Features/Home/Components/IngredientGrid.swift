/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that displays a horizontal grid of seasonal ingredients.
*/

import SwiftUI

extension Home {
    struct IngredientGrid: View {
        @Namespace private var namespace
    
        let rows = [
            GridItem(.flexible(), spacing: BarTinderApp.Padding.scrollViewSpacing),
            GridItem(.flexible(), spacing: BarTinderApp.Padding.scrollViewSpacing)
        ]
        
        var body: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: BarTinderApp.Padding.scrollViewSpacing) {
                    ForEach(CardIngredient.ingredientCards.filter { $0.summer == true }, id: \.self) { ingredient in
                        NavigationLink(value: RouterDestination.cocktailList(ingredient)) {
                            Image(ingredient.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 200)
                                .bartinderRounder()
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    Home.IngredientGrid()
}


