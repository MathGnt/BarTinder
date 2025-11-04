/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays an animated card to access Apple Intelligence cocktail suggestions.
*/

import SwiftUI

extension Home {
    struct GetInspiredCard: View {
        @State private var animationTimer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
        @State private var gradientIndex: Int = 0
        
        private let colorSets: [[Color]] = [
            [
                .pink.opacity(0.9), .purple.opacity(0.8), .orange.opacity(0.7),
                .red.opacity(0.6), .pink.opacity(0.9), .purple.opacity(0.8),
                .orange.opacity(0.8), .red.opacity(0.7), .pink.opacity(0.9)
            ],
            [
                .purple.opacity(0.9), .blue.opacity(0.8), .pink.opacity(0.7),
                .orange.opacity(0.6), .purple.opacity(0.9), .blue.opacity(0.8),
                .pink.opacity(0.8), .orange.opacity(0.7), .purple.opacity(0.9)
            ],
            [
                .orange.opacity(0.9), .red.opacity(0.8), .purple.opacity(0.7),
                .pink.opacity(0.6), .orange.opacity(0.9), .red.opacity(0.8),
                .purple.opacity(0.8), .pink.opacity(0.7), .orange.opacity(0.9)
            ]
        ]
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                    ],
                    colors: colorSets[gradientIndex]
                )
                .onReceive(animationTimer) { _ in
                    withAnimation(.easeInOut(duration: 1.5)) {
                        gradientIndex = (gradientIndex + 1) % colorSets.count
                    }
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
                    
                    HStack {
                        Text("Ask for")
                        Text("a")
                            .foregroundStyle(.writings)
                            .saturation(1.4)
                        
                    }
                    .fontWeight(.semibold)
                    Text("Cocktail idea")
                        .foregroundStyle(.writings)
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
