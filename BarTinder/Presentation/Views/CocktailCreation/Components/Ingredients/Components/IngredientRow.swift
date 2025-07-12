//
//  IngredientRow.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 27/06/2025.
//
import Foundation
import SwiftUI

extension IngredientsListCreation {
    /// A view that shows a row of a selected ingredient.
    struct IngredientRow: View {
        @FocusState.Binding var focus: Focus?
        @Bindable var ingredient: Ingredient
        
        let model: CreationModel
        
        var body: some View {
            VStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
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
                        
                        TextField(model.textFieldPlaceholder(ingredient.unit), text: $ingredient.measure)
                            .focused($focus, equals: .measure)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                }
                
                Picker("Unit:", selection: $ingredient.unit) {
                    ForEach(Units.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .onChange(of: ingredient.unit) { _, newValue in
                    model.removeMeasure(ingredient, newValue)
                }
            }
        }
    }
}

#Preview {
    @Previewable @FocusState var focus: Focus?
    List {
        IngredientsListCreation.IngredientRow(focus: $focus, ingredient: Ingredient.gin, model: PatchBay.patch.makeCreationModel())
    }
}
