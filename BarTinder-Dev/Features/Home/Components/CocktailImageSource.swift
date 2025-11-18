/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that shows a cocktail image card.
*/


import SwiftUI

extension Home.YourCocktailsScrollView {
    struct CocktailImageSource: View {
        @Environment(\.modelContext) private var context
        @Environment(\.router) private var router
        let cocktail: Cocktail
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(cocktail.name)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                cocktail.displayedImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: BarTinderApp.Size.cardWidth, height: BarTinderApp.Size.cardHeight)
                    .bartinderRounder()
                    .contentShape(
                        .contextMenuPreview,
                        RoundedRectangle(cornerRadius: BarTinderApp.CornerRadius.main)
                    )
                    .contextMenu {
                        Button("Edit", systemImage: "rectangle.and.pencil.and.ellipsis") {
                            router.presentSheet(.cocktailEdit(cocktail))
                        }
                        .disabled(cocktail.stock)
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            withAnimation {
                                context.contextDelete(cocktail)
                            }
                        }
                        .animation(.easeInOut, value: cocktail)
                    }
            }
        }
    }
}

#Preview(traits: .modelsEnvironment) {
    Home.YourCocktailsScrollView.CocktailImageSource(cocktail: Cocktail.ginto)
}
