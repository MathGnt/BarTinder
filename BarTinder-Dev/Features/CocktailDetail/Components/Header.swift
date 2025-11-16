/*
 See the LICENSE file for this project's licensing information.
 
 Abstract:
 A SwiftUI view component that displays the header image for a cocktail detail screen.
 */

import SwiftUI

extension CocktailDetail {
    struct CocktailHeaderPicture: View {
        @Environment(\.colorScheme) private var scheme
        let cocktail: Cocktail
        
        var body: some View {
            cocktail.displayedImage
                .resizable()
                .scaledToFill()
                .frame(height: 480)
                .clipped()
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(
                            .linearGradient(colors: [
                                .inverted.opacity(0),
                                .inverted.opacity(0.1),
                                .inverted.opacity(0.3),
                                .inverted.opacity(0.5),
                                .inverted.opacity(0.8),
                                .inverted.opacity(1)
                            ], startPoint: .top, endPoint: .bottom)
                        )
                }
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    CocktailDetail.CocktailHeaderPicture(cocktail: Cocktail.ginto)
}
