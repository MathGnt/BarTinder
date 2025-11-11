/*
See the LICENSE file for this project's licensing information.

Abstract:
A view modifier that implements a custom character limit for TextField.
*/

import Foundation
import SwiftUI

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
