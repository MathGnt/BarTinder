//
//  IngredientCard.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 16/04/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct IngredientCard: View {
    
    let cardIngredient: CardIngredient
    let viewModel: SwipeViewModel
    
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
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            LinearGradient(colors: [.clear, .black],
                           startPoint: .center,
                           endPoint: .bottom)
            .frame(width: cardWidth, height: cardHeight - 200)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            cardInfo(title: cardIngredient.name, abv: cardIngredient.abv ?? "", location: cardIngredient.location)
        }
        .offset(x: viewModel.getOffset(for: cardIngredient))
        .rotationEffect(.degrees(viewModel.getRotation(for: cardIngredient)))
        .animation(.snappy, value: viewModel.getOffset(for: cardIngredient))
        .gesture(
            DragGesture()
                .onChanged { value in
                    viewModel.onChangedGesture(card: cardIngredient, translation: value.translation.width)
                }
                .onEnded { value in
                    viewModel.onEndedGesture(value, cardIngredient)
                }
        )
    }
}

#Preview {
    IngredientCard(cardIngredient: CardIngredient.mocks, viewModel: PatchBay.patch.makeSwipeViewModel())
}

//MARK: - View Function
    
private extension IngredientCard {
    
    private func cardInfo(title: String, abv: String, location: String) -> some View {
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



