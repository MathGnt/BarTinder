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
            HStack(alignment: .center, spacing: 12) {
                if let ingredientLogo = ingredient?.name?.logolized() {
                    Image(ingredientLogo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: BarTinderApp.Size.image, height: BarTinderApp.Size.image)
                        .clipShape(Circle())
                        .background(Circle().fill(.gray.opacity(0.1)))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    if let ingredientName = ingredient?.name {
                        Text(ingredientName.capitalizedWords)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    
                    HStack(spacing: 5) {
                        if let ingredientAmount = ingredient?.amount {
                            if let ingredientUnit = ingredient?.unit {
                                if ingredientUnit != "To Rinse" && ingredientUnit != "Top Up" {
                                    Text(String(ingredientAmount))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Text(ingredientUnit)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    GeneratedCocktail.InfosCard.IngredientRowGenerable(ingredient: nil)
}
