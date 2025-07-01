//
//  AllIngredients.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/06/2025.
//

import SwiftUI


extension IngredientsListCreation {
    /// A view displaying all ingredients the user can choose from to make their cocktail.
    struct AllIngredients: View {
        let cocktail: Cocktail
        let ingredient: CardIngredient
        let viewModel: CreationViewModel
        
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
                    viewModel.addIngredient(cocktail, ingredient)
                } label: {
                    Image(systemName: cocktail.ingredients.contains(where: { $0.name == ingredient.name }) ? "checkmark.circle.fill" : "plus.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(cocktail.ingredients.contains(where: { $0.name == ingredient.name }) ? .green : .turborider)
                }
                .buttonStyle(.borderless)
            }
        }
    }
}

#Preview {
    IngredientsListCreation.AllIngredients(cocktail: Cocktail.ginto, ingredient: CardIngredient.gin, viewModel: PatchBay.patch.makeCreationViewModel())
}
