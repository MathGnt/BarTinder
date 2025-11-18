/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that displays all available ingredients for selection during cocktail creation.
*/

import SwiftUI

extension IngredientsListCreation {
    struct AvailableIngredientRow: View {
        let cocktail: Cocktail
        let ingredient: CardIngredient
        let model: IngredientCreationModel
        
        var body: some View {
            HStack {
                IngredientRowLabel(ingredientName: ingredient.name)
                Spacer()
                Button {
                    model.addIngredient(cocktail, ingredient)
                } label: {
                    Image(systemName: cocktail.ingredients.contains(where: { $0.name == ingredient.name }) ? "checkmark.circle.fill" : "plus.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(cocktail.ingredients.contains(where: { $0.name == ingredient.name }) ? .green : .turborider)
                }
                .buttonStyle(.borderless)
                .disabled(cocktail.ingredients.contains(where: { $0.name == ingredient.name}))
            }
        }
    }
}

#Preview(traits: .modelsEnvironment) {
    IngredientsListCreation.AvailableIngredientRow(cocktail: Cocktail.ginto, ingredient: CardIngredient.ingredientCards[4], model: IngredientCreationModel())
}
