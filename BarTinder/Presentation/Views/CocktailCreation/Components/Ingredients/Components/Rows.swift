//
//  Rows.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 27/06/2025.
//
import Foundation
import SwiftUI

extension IngredientsListCreation {
    
    struct AllIngredients: View {
        let cocktail: Cocktail
        let ingredient: CardIngredient
        let viewModel: CocktailCreationViewModel
        
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
                        .frame(width: 20, height: 20)
                        .foregroundStyle(cocktail.ingredients.contains(where: { $0.name == ingredient.name }) ? .green : .turborider)
                }
                .buttonStyle(.borderless)
            }
        }
    }
    
    struct IngredientRow: View {
        
        @FocusState.Binding var focus: Focus?
        @Bindable var ingredient: Ingredient
        let viewModel: CocktailCreationViewModel
        var body: some View {
            VStack(spacing: 15) {
                HStack {
                    Image(ingredient.name.logolized())
                        .resizable()
                        .scaledToFill()
                        .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(ingredient.name.capitalizedWords)
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                if ingredient.unit != .topUp && ingredient.unit != .toRinse {
                    HStack {
                        Text("Measure:")
                        Spacer()
                        
                        TextField(viewModel.textFieldPlaceholder(ingredient.unit), text: $ingredient.measure)
                            .focused($focus, equals: .measure)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                }
                
                Picker("Unit", selection: $ingredient.unit) {
                    ForEach(Units.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .onChange(of: ingredient.unit) { _, newValue in
                    viewModel.removeMeasure(ingredient, newValue)
                }
            }
        }
    }
}


