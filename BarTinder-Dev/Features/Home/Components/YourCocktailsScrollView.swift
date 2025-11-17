/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that displays a horizontal scrollable list of the user's cocktails.
*/

import SwiftUI
import SwiftData

extension Home {
    struct YourCocktailsScrollView: View {
        @Namespace private var cocktailZoom
        @Query private var cocktails: [Cocktail]
        
        init(descriptor: FetchDescriptor<Cocktail>) {
            _cocktails = Query(descriptor)
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

#Preview(traits: .queryMocks, .barTinderEnvironments) {
    Home.YourCocktailsScrollView(descriptor: FetchDescriptor<Cocktail>())
}


