/*
 See the LICENSE file for this project's licensing information.
 
 Abstract:
 A SwiftUI view component to add and see the cocktail's selected ingredients.
 */

import SwiftUI

extension CreateEditCocktail {
    struct IngredientsSection: View {
        @Environment(\.router) private var router
        @Environment(\.modelContext) private var context
        let cocktail: Cocktail

        var body: some View {
            Button {
                router.presentSheet(.ingredientsEdit(cocktail))
            } label: {
                SelectYourIngredientsLabel(cocktail: cocktail)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
            
            ForEach(cocktail.ingredients) { ingredient in
                HStack {
                    IngredientRowLabel(ingredientName: ingredient.name)
                    Spacer()
                    Text(ingredient.measure + " " + ingredient.unit.rawValue)
                }
            }
        }
    }
}

private struct SelectYourIngredientsLabel: View {
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


#Preview(traits: .barTinderEnvironments) {
    CreateEditCocktail.IngredientsSection(cocktail: Cocktail.ginto)
}
