//
//  IngredientsList.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/06/2025.
//

import SwiftUI

extension CocktailDetail {
    /// A view that list all ingredients of the selected cocktail
    struct IngredientsList: View {
        let cocktail: Cocktail
        
        var body: some View {
            VStack(alignment: .center, spacing: 4) {
                Text("Ingredients")
                    .font(.system(size: 17, design: .serif))
                Spacer(minLength: BarTinderApp.Padding.ingredientSpacing)
                ForEach(cocktail.ingredients) { ingredient in
                    HStack {
                        Image(ingredient.name.logolized())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text(ingredient.name.capitalizedWords)
                        Spacer()
                        Text("\(ingredient.measure) \(ingredient.unit.rawValue)")
                    }
                }
            }
        }
    }
}

#Preview {
    CocktailDetail.IngredientsList(cocktail: Cocktail.ginto)
}
