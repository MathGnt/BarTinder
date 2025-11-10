/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays a swipeable card for an ingredient with drag gesture support.
*/

import SwiftUI
import SwiftData

extension Swipe {
    struct IngredientCard: View {
        @State private var offset: CGFloat = 0
        @State private var rotation: Double = 0
        @Environment(\.screenWidth) private var screenWidth
        @Environment(\.screenHeight) private var screenHeight
        let cardIngredient: CardIngredient
        let model: IngredientsModel
    
        var threshold: CGFloat { (screenWidth / 2) * 0.8 }
        private var cardWidth: CGFloat { screenWidth - 30 }
        private var cardHeight: CGFloat { screenHeight / 1.3 }
        
        var body: some View {
            ZStack(alignment: .bottom) {
                Image(cardIngredient.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .bartinderRounder()

                LinearGradient(colors: [.clear, Color(.systemGray)],
                               startPoint: .center,
                               endPoint: .bottom)
                .frame(width: cardWidth, height: cardHeight - 200)
                .bartinderRounder()

                CardInfo(title: cardIngredient.name, abv: cardIngredient.abv ?? "", location: cardIngredient.location)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation.width
                        rotation = value.translation.width / 25
                    }
                    .onEnded { value in
                        handleSwipe(value)
                    }
            )
            .offset(x: offset)
            .rotationEffect(.degrees(rotation))
            .animation(.default, value: offset)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(cardIngredient.name) from \(cardIngredient.location)")
            .accessibilityAddTraits(.isButton)
        }
        
        private func handleSwipe(_ value: DragGesture.Value) {
            if value.translation.width >= threshold {
                offset = BarTinderApp.SwipingSettings.swipeOutDistance
                rotation = BarTinderApp.SwipingSettings.maxRotation
                Task { await model.swipeRight(card: cardIngredient) }
            } else if value.translation.width <= -threshold {
                offset = -BarTinderApp.SwipingSettings.swipeOutDistance
                rotation = -BarTinderApp.SwipingSettings.maxRotation
                Task { await model.swipeLeft(card: cardIngredient)  }
            } else {
                offset = 0
                rotation = 0
            }
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    GeometryReader { proxy in
        Swipe.IngredientCard(
            cardIngredient: CardIngredient.ingredientCards[13],
            model: IngredientsModel()
        )
        .environment(\.screenWidth, proxy.size.width)
        .environment(\.screenHeight, proxy.size.height)
    }
}


private struct CardInfo: View {
    let title: String
    let abv: String
    let location: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text(title.capitalized)
                        .cardTitle()
                    
                    Text(abv)
                        .cardABV()
                }
                Text("From \(location)")
                    .cardLocation()
            }
            .padding(.horizontal, 50)
            .padding(.bottom, 15)
            Spacer()
        }
    }
}

