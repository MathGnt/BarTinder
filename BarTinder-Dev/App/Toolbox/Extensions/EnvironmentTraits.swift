/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A custom preview trait to share all BarTinder models through the previews.
*/

import Foundation
import SwiftUI

struct BarTinderEnvironments: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        content
            .environment(Router())
            .environment(GenerableModel())
            .environment(CocktailModel())
            .environment(CocktailCreationModel())
            .environment(IngredientsModel())
            .environment(IngredientCreationModel())
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var barTinderEnvironments: Self = .modifier(BarTinderEnvironments())
}



