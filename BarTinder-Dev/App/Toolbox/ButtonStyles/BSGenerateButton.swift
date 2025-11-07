/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A custom button style for the 'generate' buttons.
*/

import Foundation
import SwiftUI

struct GenerateButton: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(color, in: .capsule)
            .buttonStyle(.plain)
    }
}
