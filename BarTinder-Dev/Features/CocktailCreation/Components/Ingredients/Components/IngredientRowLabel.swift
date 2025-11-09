/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A row component displaying a label for an ingredient.
*/

import SwiftUI

struct IngredientRowLabel: View {
    let ingredientName: String
    
    var body: some View {
        Image(ingredientName.logolized())
            .resizable()
            .scaledToFill()
            .frame(width: BarTinderApp.Size.image, height: BarTinderApp.Size.image)
        Text(ingredientName.capitalized)
            .fontWeight(.medium)
    }
}

#Preview(traits: .barTinderEnvironments) {
    IngredientRowLabel(ingredientName: "gin")
}
