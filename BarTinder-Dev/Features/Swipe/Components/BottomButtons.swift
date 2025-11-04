/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays action buttons for swiping ingredients.
*/

import SwiftUI

extension Swipe {
    struct BottomButtons: View {
        let image: String
        let color: Color
        let action: () -> Void
        var body: some View {
            Button {
                action()
            } label: {
                Circle()
                    .frame(height: 60)
                    .foregroundStyle(.white)
                    .overlay {
                        Image(systemName: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: image != "wineglass.fill" ? 20 : 15, height: 20)
                            .foregroundStyle(color)
                    }
            }
            .glassEffect(.regular.tint(.applered).interactive())
            .accessibilityLabel(image == "xmark" ? "Dislike this ingredient" : "Like this ingredient")
            .accessibilityHint("Swipe left to dislike, or right to like")
        }
    }
}
