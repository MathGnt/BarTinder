/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI component that shows the header for a generated cocktail.
*/

import Foundation
import SwiftUI

extension GeneratedCocktail {
    struct TitleHeader: View {
        @Environment(GenerableModel.self) private var model
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                if let cocktailName = model.cocktailIdea?.content.name {
                    Text(cocktailName)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    HStack(alignment: .top) {
                        Image(systemName: "sparkles")
                        Text("Crafting the best cocktail that fits your idea...")
                    }
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                }
                if let cocktailDescription = model.cocktailIdea?.content.description {
                    Text(cocktailDescription)
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .lineLimit(4)
                        .fixedSize(horizontal: false, vertical: true)
                        .opacity(0.9)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
