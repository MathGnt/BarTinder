/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays a horizontal scrollable list of the user's cocktails.
*/

import SwiftUI
import SwiftData

extension Home {
    struct YourCocktailsScrollView: View {
        @Bindable var model: CocktailModel
        @Namespace private var cocktailZoom
        @Query private var cocktails: [Cocktail]
        
        init(model: CocktailModel) {
            self.model = model
            _cocktails = Query(model.yourCocktailsDescriptor)
        }
        
        var body: some View {
            if cocktails.isEmpty {
                ContentUnavailableView("No cocktails", systemImage: "wineglass", description: Text("You don't have any cocktails that fulfill this search."))
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: BarTinderApp.Padding.scrollViewSpacing) {
                        ForEach(cocktails) { cocktail in
                            NavigationLink(value: RouterDestination.cocktailDetail(cocktail, cocktailZoom)) {
                                CocktailImageSource(cocktail: cocktail)
                                    .matchedTransitionSource(id: cocktail.id, in: cocktailZoom)
                                    // Confirmed iOS 26 bug -> image disappear after dismissing
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

private struct CocktailImageSource: View {
    @Environment(\.modelContext) private var context
    @Environment(Router.self) private var router
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
                        router.presentSheet(.cocktailEdit(context.switch(for: cocktail)))
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

#Preview(traits: .queryMocks, .barTinderEnvironments) {
    Home.YourCocktailsScrollView(model: CocktailModel())
}
