/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI component that shows a mesh gradient on top of the sheet.
*/

import SwiftUI

extension GeneratedCocktail {
    struct HeaderMesh: View {
        var body: some View {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .pink.opacity(0.8), .purple.opacity(0.7), .blue.opacity(0.6),
                    .orange.opacity(0.8), .red.opacity(0.7), .purple.opacity(0.8),
                    .turborider.opacity(0.8), .pink.opacity(0.8), .blue.opacity(0.9)
                ]
            )
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .compositingGroup()
            .mask {
                Rectangle()
                    .fill(
                        Gradient(stops: [
                            .init(color: .white, location: 0.3),
                            .init(color: .clear, location: 1.0)
                        ])
                        .colorSpace(.perceptual)
                    )
            }
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    GeneratedCocktail.HeaderMesh()
}
