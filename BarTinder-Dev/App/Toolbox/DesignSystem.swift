//
//  DesignSystem.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 26/06/2025.
//

import Foundation
import SwiftUI

extension BarTinderApp {
    enum Padding {
        static let image: CGFloat = 40
        static let mainCornerRadius: CGFloat = 20
        static let ingredientSpacing: CGFloat = 15
        static let scrollViewSpacing: CGFloat = 10
        static let titleSpacingTop: CGFloat = 15
        static let titleSpacingBottom: CGFloat = 5
        static let bigTitleSpacingTop: CGFloat = 30
        static let bigTitleSpacingBottom: CGFloat = 20
        static let scrollViewVerticalSpacing: CGFloat = 5
    }
}


//MARK: Ingredient Card setup

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
            .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
    }
}

private struct PreviewCard: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorScheme == .dark ? AnyShapeStyle(.thinMaterial) : AnyShapeStyle(.white))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.08), radius: 4, y: 2)
            .shadow(color: .black.opacity(colorScheme == .dark ? 0.12 : 0.08), radius: 32, y: 12)
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
    func previewCard() -> some View {
        modifier(PreviewCard())
    }
}

struct GenerateButton: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(color)
            .buttonStyle(.plain)
            .clipShape(RoundedRectangle(cornerRadius: 50))
    }
}

//MARK: Own stuff

private struct CharacterLimitModifier: ViewModifier {
    let limit: Int
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { _, newValue in
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
