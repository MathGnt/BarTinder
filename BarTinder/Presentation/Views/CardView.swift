//
//  CarView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 16/04/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct CardView: View {
    
    let card: Ingredient
    let viewModel: SwipeViewModel
    
    @Environment(\.swiftData) private var dataBase
    
    private var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    private var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.45
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(card.image)
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 30))
               
            LinearGradient(colors: [.clear, .black],
                            startPoint: .center,
                            endPoint: .bottom)
                 .frame(width: cardWidth, height: cardHeight - 200)
                 .clipShape(RoundedRectangle(cornerRadius: 30))
            
            cardInfo(title: card.name, avb: card.AVB ?? "", location: card.location)
        }
        .offset(x: viewModel.getOffset(for: card))
        .rotationEffect(.degrees(viewModel.getRotation(for: card)))
        .animation(.snappy, value: viewModel.getOffset(for: card))
        .gesture(
            DragGesture()
                .onChanged { value in
                    viewModel.onChangedGesture(card: card, translation: value.translation.width)
                }
                .onEnded { value in
                    viewModel.onEndedGesture(value, card)
                }
        )
    }
    
    //MARK: - View Function
    
    private func cardInfo(title: String, avb: String, location: String) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text(title.prefix(1).uppercased() + title.dropFirst())
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    Text(avb)
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                        .foregroundColor(.white)
                }
                Text("From \(location)")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.leading, 7)
                    .padding(.trailing, 7)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 50)
            .padding(.bottom, 15)
            Spacer()
        }
    }
}


#Preview {
    CardView(card: Ingredient.mocks, viewModel: PatchBay.patch.makeSwipeViewModel())
}
