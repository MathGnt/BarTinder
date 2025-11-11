/*
See the LICENSE file for this project's licensing information.

Abstract:
A view modifier that handles the different card modifiers.
*/

import Foundation
import SwiftUI

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
    func previewCard() -> some View {
        modifier(PreviewCard())
    }
}
