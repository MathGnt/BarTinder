/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays an animated card to access Apple Intelligence cocktail suggestions.
*/

import SwiftUI

extension Home {
    struct GetInspiredCard: View {
        var body: some View {
            ZStack(alignment: .topLeading) {
                TimelineView(.animation) { context in
                    let time = context.date.timeIntervalSince1970
                    let offsetX = Float(sin(time)) * 0.4
                    let offsetY = Float(cos(time)) * 0.4

                    MeshGradient(
                        width: 3,
                        height: 3,
                        points: [
                            [0.0, 0.0],
                            [0.5 + offsetX, 0.0],
                            [1.0, 0.0],
                            [0.0, 0.5],
                            [0.5 + offsetX, 0.5],
                            [1.0, 0.5 + offsetY],
                            [0.0, 1.0],
                            [0.5, 1.0],
                            [1.0, 1.0]
                        ],
                        colors: [
                              .purple, .indigo, .purple, .yellow,
                              .pink, .purple, .pink, .yellow,
                              .orange, .pink, .yellow, .orange,
                              .yellow, .orange, .pink, .purple
                          ]
                    )
                }
                
                Rectangle()
                    .fill(
                        RadialGradient(
                            colors: [.clear, .black.opacity(0.1)],
                            center: .center,
                            startRadius: 100,
                            endRadius: 300
                        )
                    )
                
                Rectangle()
                    .fill(
                        LinearGradient(
                            stops: [
                                .init(color: .black.opacity(0.4), location: 0.0),
                                .init(color: .clear, location: 0.6)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Image("cocktailglasspreview")
                    .resizable()
                    .renderingMode(.template)
                    .font(.system(size: 300, weight: .ultraLight))
                    .foregroundStyle(.white.opacity(0.14))
                    .rotationEffect(.degrees(-20))
                    .offset(x: 40, y: 40)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading) {
                    Text(" Intelligence")
                        .fontWeight(.semibold)
                        .font(.system(size: 25))
                    
                    VStack(alignment: .leading) {
                        Text("Ask for a")
                        Text("Cocktail idea")
                    }
                    .fontWeight(.semibold)
                }
                .font(.system(size: 35))
                .foregroundStyle(.white)
                .padding()
            }
            .frame(height: 400)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
            
        }
    }
}

#Preview {
    Home.GetInspiredCard()
}
