/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays a horizontal grid of seasonal ingredients.
*/

import SwiftUI

extension Home {
    struct IngredientGrid: View {
        @Environment(Router.self) private var router
        @Namespace private var namespace
    
        let rows = [
            GridItem(.flexible(), spacing: BarTinderApp.Padding.scrollViewSpacing),
            GridItem(.flexible(), spacing: BarTinderApp.Padding.scrollViewSpacing)
        ]
        
        var body: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: BarTinderApp.Padding.scrollViewSpacing) {
                    ForEach(CardIngredient.ingredientCards.filter { $0.summer == true }, id: \.self) { ingredient in
                        Image(ingredient.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                            .onTapGesture {
                                router.navigateTo(.cocktailList(ingredient))
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    Home.IngredientGrid()
        .environment(Router())
}


