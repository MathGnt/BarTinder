/*
 See the LICENSE file for this project's licensing information.
 
 Abstract:
 A SwiftUI view component that displays a list of all ingredients for a cocktail.
 */

import SwiftUI

extension CocktailDetail {
    struct IngredientsList: View {
        let cocktail: Cocktail
        
        var body: some View {
            VStack(alignment: .center, spacing: 5) {
                ForEach(cocktail.ingredients) { ingredient in
                    HStack {
                        IngredientRowLabel(ingredientName: ingredient.name)
                        Spacer()
                        HStack(spacing: BarTinderApp.Padding.tightSpacing) {
                            Text(ingredient.measure)
                            Text(ingredient.unit.rawValue)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(.ingredientCapsule, in: .capsule)
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    CocktailDetail.IngredientsList(cocktail: Cocktail.ginto)
}
