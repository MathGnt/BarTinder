//
//  IngredientCard.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 16/04/2025.
//

import Foundation
import SwiftUI
import SwiftData

extension Swipe {
    
    struct IngredientCard: View {
        
        let cardIngredient: CardIngredient
        let model: SwipeModel
        
        private var cardWidth: CGFloat {
            UIScreen.main.bounds.width - 20
        }
        
        private var cardHeight: CGFloat {
            UIScreen.main.bounds.height / 1.45
        }
        
        var body: some View {
            ZStack(alignment: .bottom) {
                Image(cardIngredient.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                
                LinearGradient(colors: [.clear, .black],
                               startPoint: .center,
                               endPoint: .bottom)
                .frame(width: cardWidth, height: cardHeight - 200)
                .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                
                CardInfo(title: cardIngredient.name, abv: cardIngredient.abv ?? "", location: cardIngredient.location)
            }
            .offset(x: model.getOffset(for: cardIngredient))
            .rotationEffect(.degrees(model.getRotation(for: cardIngredient)))
            .animation(.snappy, value: model.getOffset(for: cardIngredient))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        model.onChangedGesture(card: cardIngredient, translation: value.translation.width)
                    }
                    .onEnded { value in
                        model.onEndedGesture(value, cardIngredient)
                    }
            )
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(cardIngredient.name) from \(cardIngredient.location)")
            .accessibilityAddTraits(.isButton)
            .accessibilityAction(named: "Like") {
                model.triggerSwipeRight(card: cardIngredient)
            }
            .accessibilityAction(named: "Dislike") {
                model.triggerSwipeLeft(card: cardIngredient)
            }
        }
    }
    
    #Preview {
        IngredientCard(cardIngredient: CardIngredient.gin, model: PatchBay.patch.makeSwipeModel())
    }
    
    
    private struct CardInfo: View {
        let title: String
        let abv: String
        let location: String
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(title.prefix(1).uppercased() + title.dropFirst())
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
}
