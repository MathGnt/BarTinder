//
//  SelectIngredientsLabel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/06/2025.
//

import SwiftUI

extension CreateEditCocktail {
    /// A label for the button that will show @IngredientsListCreation
    struct SelectYourIngredientsLabel: View {
        let cocktail: Cocktail
        
        var body: some View {
            HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                let isEmpty = cocktail.ingredients.isEmpty
                Image(systemName: "flask.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                
                    .foregroundStyle(.bartinderclr)
                    .overlay {
                        Image(systemName: isEmpty ? "plus.circle.fill" : "minus.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(isEmpty ? .validate : .applered)
                            .offset(x: 10, y: -5)
                    }
                Text(isEmpty ? "Select your ingredients" : "Modify your ingredients")
            }
        }
    }
}

#Preview {
    CreateEditCocktail.SelectYourIngredientsLabel(cocktail: Cocktail.ginto)
}
