//
//  DesignSystem.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 26/06/2025.
//

import Foundation
import SwiftUI

extension BarTinderApp {
    struct Padding {
        static let image: CGFloat = 40
    }
}


// INGREDIENT CARD

private struct CardTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .font(.system(size: 30, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
    }
}

private struct CardABV: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .regular, design: .rounded))
            .foregroundColor(.white)
    }
}

private struct CardLocation: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .padding(.leading, 7)
            .padding(.trailing, 7)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func cardTitle() -> some View {
        modifier(CardTitle())
    }
    func cardABV() -> some View {
        modifier(CardABV())
    }
    func cardLocation() -> some View {
        modifier(CardLocation())
    }
}


private struct CharacterLimitModifier: ViewModifier {
    let limit: Int
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { oldValue, newValue in
                if newValue.count > limit {
                    text = String(newValue.prefix(limit))
                }
            }
    }
}

extension TextField {
    func characterLimit(_ limit: Int, text: Binding<String>) -> some View {
        modifier(CharacterLimitModifier(limit: limit, text: text))
    }
}
