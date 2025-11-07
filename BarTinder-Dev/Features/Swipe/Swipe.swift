/*
See the LICENSE.txt file for this sample's licensing information.

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
                Image("centeredlogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                    .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                    .accessibilityHidden(true)
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

#Preview {
    GeometryReader { proxy in
        Swipe()
            .environment(Router())
            .environment(\.screenWidth, proxy.size.width)
            .environment(\.screenHeight, proxy.size.height)
    }
}
