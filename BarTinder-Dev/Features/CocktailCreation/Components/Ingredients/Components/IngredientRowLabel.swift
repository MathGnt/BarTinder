/*
See the LICENSE file for this project's licensing information.

Abstract:
A row component displaying a label for an ingredient.
*/

import SwiftUI

struct IngredientRowLabel: View {
    let ingredientName: String
    
    var body: some View {
        Image(ingredientName.logolized())
            .resizable()
            .scaledToFit()
            .frame(width: BarTinderApp.Size.image, height: BarTinderApp.Size.image)
        Text(ingredientName.capitalized)
            .fontWeight(.medium)
    }
}

#Preview(traits: .modelsEnvironment) {
    IngredientRowLabel(ingredientName: "prosecco")
}
