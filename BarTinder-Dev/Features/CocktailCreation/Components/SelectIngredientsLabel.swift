/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays a button label for selecting or modifying ingredients.
*/

import SwiftUI

extension CreateEditCocktail {
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
