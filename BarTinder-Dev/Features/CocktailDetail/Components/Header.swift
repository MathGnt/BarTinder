/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays the header image for a cocktail detail screen.
*/

import SwiftUI

extension CocktailDetail {
    struct CocktailHeaderPicture: View {
        @Environment(\.colorScheme) private var scheme
        let cocktail: Cocktail
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                cocktail.displayedImage
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                cocktail.displayedImage
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .blur(radius: 16, opaque: true)
                    .saturation(1.3)
                    .brightness(0.15)
                    .mask {
                        Rectangle()
                            .fill(
                                Gradient(stops: [
                                    .init(color: .clear, location: 0.5),
                                    .init(color: .white, location: 0.65)
                                ])
                                .colorSpace(.perceptual)
                            )
                    }
            }
            .frame(height: 400)
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
            .ignoresSafeArea()
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    CocktailDetail.CocktailHeaderPicture(cocktail: Cocktail.ginto)
}
