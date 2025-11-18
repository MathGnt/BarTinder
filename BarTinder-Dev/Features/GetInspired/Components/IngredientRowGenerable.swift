/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI component that shows a row for a generated ingredient.
*/

import SwiftUI

extension GeneratedCocktail.InfosCard {
    struct IngredientRowGenerable: View {
        let ingredient: IngredientIdea.PartiallyGenerated?
        
        var body: some View {
                if let ingredientName = ingredient?.name,
                   let ingredientMeasure = ingredient?.amount,
                   let ingredientUnit = ingredient?.unit {
                    HStack {
                        IngredientRowLabel(ingredientName: ingredientName)
                        Spacer()
                        HStack(spacing: BarTinderApp.Padding.tightSpacing) {
                            Text(ingredientMeasure, format: .number)
                            Text(ingredientUnit)
                        }
                    }
                   
                }
        }
    }
}

#Preview(traits: .modelsEnvironment) {
    GeneratedCocktail.InfosCard.IngredientRowGenerable(ingredient: nil)
}
