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
        @Query private var cocktails: [Cocktail]
        @Namespace private var cocktailZoom
        
        init(model: CocktailModel) {
            self.model = model
            
            /// Dynamic filtering & sorting
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
                                    // Bug iOS 26 image disappear after dismissing
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
                .frame(width: 180, height: 260)
                .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                .contentShape(
                    .contextMenuPreview,
                    RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius)
                )
                .contextMenu {
                    if !cocktail.stock {
                        Button("Edit", systemImage: "rectangle.and.pencil.and.ellipsis") {
                            router.presentSheet(.cocktailEdit(context.switch(for: cocktail)))
                        }
                    }
                    Button(role: .destructive) {
                        withAnimation {
                            context.contextDelete(cocktail)
                        }
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .animation(.easeInOut, value: cocktail)
                }
        }
    }
}

#Preview(traits: .queryMocks) {
    Home.YourCocktailsScrollView(model: CocktailModel())
        .environment(Router())
}
