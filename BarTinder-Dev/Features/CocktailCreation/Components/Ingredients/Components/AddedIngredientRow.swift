/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI component that display an ingredient row.
*/

import Foundation
import SwiftUI

extension IngredientsListCreation {
    struct AddedIngredientRow: View {
        @Bindable var ingredient: Ingredient
        let model: IngredientCreationModel
        
        var body: some View {
            VStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                HStack {
                    IngredientRowLabel(ingredientName: ingredient.name)
                Spacer()
                }
                if ingredient.unit.needsMeasure {
                    HStack {
                        Text("Measure:")
                        Spacer()
                        TextField(model.textFieldPlaceholder(ingredient.unit), text: $ingredient.measure)
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

#Preview(traits: .barTinderEnvironments) {
    List {
        IngredientsListCreation.AddedIngredientRow(ingredient: Ingredient.gin, model: IngredientCreationModel())
    }
}
