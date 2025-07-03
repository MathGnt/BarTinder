//
//  IngredientRowGenerable.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/07/2025.
//

import SwiftUI

struct IngredientRowGenerable: View {
    let ingredient: IngredientIdea.PartiallyGenerated?
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            if let ingredientLogo = ingredient?.name?.logolized() {
                Image(ingredientLogo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                    .clipShape(Circle())
                    .background(Circle().fill(.gray.opacity(0.1)))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                if let ingredientName = ingredient?.name {
                    Text(ingredientName.capitalizedWords)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
                HStack(spacing: 1) {
                    if let ingredientAmount = ingredient?.amount {
                        Text(String(ingredientAmount))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    if let ingredientUnit = ingredient?.unit {
                        Text(ingredientUnit)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
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

//#Preview {
//    IngredientRowGenerable()
//}
