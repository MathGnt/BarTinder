/*
See the LICENSE file for this project's licensing information.

Abstract:
A custom preview trait to share all BarTinder models through the previews.
*/

import SwiftUI

private struct ModelsEnvironment: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        content
            .environment(Router())
            .environment(GenerableModel())
            .environment(HomeModel())
            .environment(CocktailCreationModel())
            .environment(IngredientsModel())
            .environment(IngredientCreationModel())
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var modelsEnvironment: Self = .modifier(ModelsEnvironment())
}



