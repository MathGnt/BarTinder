/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view that presents ingredient cards for users to swipe and select their preferences.
*/

import SwiftUI
import SwiftData

struct Swipe: View {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var context
    @State private var model = IngredientsModel()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 5) {
                HStack {
                    Spacer()
                    Image("centeredlogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: BarTinderApp.Size.image, height: BarTinderApp.Size.image)
                        .bartinderRounder()
                        .accessibilityHidden(true)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
            
            ZStack {
                ForEach(model.ingredients.reversed()) { card in
                    IngredientCard(cardIngredient: card, model: model)
                }
            }
            .onChange(of: model.ingredients) { _, newValue in
                guard newValue.isEmpty else { return }
                model.updatePossibleCocktails(cocktails: context.getContent(for: Cocktail.self))
                withAnimation(.easeIn) {
                    router.hasSwiped = true
                }
            }
        }
        .transition(.opacity.combined(with: .scale))
    }
}

#Preview(traits: .barTinderEnvironments) {
    GeometryReader { proxy in
        Swipe()
            .environment(\.screenWidth, proxy.size.width)
            .environment(\.screenHeight, proxy.size.height)
    }
}
