/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI component that display an ingredient row.
*/

import Foundation
import SwiftUI

extension IngredientsListCreation {
    struct IngredientRow: View {
        @Bindable var ingredient: Ingredient
        
        let model: IngredientCreationModel
        
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
        IngredientsListCreation.IngredientRow(ingredient: Ingredient.gin, model: IngredientCreationModel(useCase: CreationUseCase(repo: CocktailRepo(cocktailDataSource: CocktailDataSource()))))
    }
}
