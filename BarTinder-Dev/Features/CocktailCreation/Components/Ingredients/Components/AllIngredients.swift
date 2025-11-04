/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays all available ingredients for selection during cocktail creation.
*/

import SwiftUI

extension IngredientsListCreation {
    struct AllIngredients: View {
        let cocktail: Cocktail
        let ingredient: CardIngredient
        let model: IngredientCreationModel
        
        var body: some View {
            HStack {
                Image(ingredient.name.logolized())
                    .resizable()
                    .scaledToFill()
                    .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                Text(ingredient.name.capitalizedWords)
                    .fontWeight(.medium)
                
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

#Preview {
    IngredientsListCreation.AllIngredients(cocktail: Cocktail.ginto, ingredient: CardIngredient.ingredientCards[4], model: IngredientCreationModel(useCase: CreationUseCase(repo: CocktailRepo(cocktailDataSource: CocktailDataSource()))))
}
