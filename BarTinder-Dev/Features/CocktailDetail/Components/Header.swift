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
                .clipped()
                .overlay(alignment: .bottom) {
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0.3),
                            .init(color: Color(uiColor: .systemBackground), location: 0.8)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .frame(height: 400)
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    CocktailDetail.CocktailHeaderPicture(cocktail: Cocktail.ginto)
}
