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
            VStack(alignment: .center, spacing: 5) {
                ForEach(cocktail.ingredients) { ingredient in
                    HStack(alignment: .center, spacing: BarTinderApp.Padding.ingredientSpacing) {
                        Image(ingredient.name.logolized())
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .padding(4)
                                .clipShape(Circle())
                                .background(Circle().fill(.gray.opacity(0.1)))
                         
                        VStack(alignment: .leading, spacing: 2) {
                          
                            Text(ingredient.name.capitalizedWords)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            
                            
                            HStack(spacing: 2) {
                          
                                Text(ingredient.measure)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                
                          
                                Text(ingredient.unit.rawValue)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(.gray.opacity(0.05), in: RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CocktailDetail.IngredientsList(cocktail: Cocktail.ginto)
}
