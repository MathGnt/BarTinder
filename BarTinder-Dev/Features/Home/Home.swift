/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view that serves as the main screen of the app.
*/

import SwiftUI
import SwiftData

struct Home: View {
    @Environment(\.modelContext) private var context
    @Environment(Router.self) private var router
    @State private var model = CocktailModel()
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.navigationPaths) {
            ScrollView {
                VStack(spacing: 0) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(CocktailFilterPredicate.allCases, id: \.self) { filter in
                                SortingScrollView(title: filter.rawValue, filterOption: filter)
                            }
                        }
                        .buttonStyle(.plain)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .scrollIndicators(.hidden)
                    
                    HomeSection("Your Cocktails") {
                        YourCocktailsScrollView(model: model)
                            .padding(.horizontal)
                            .padding(.bottom, BarTinderApp.Padding.scrollViewVerticalSpacing)
                    }
                    
                    HomeSection("Get Inspired") {
                        Button {
                            router.presentSheet(.askedForCocktail)
                        } label: {
                            GetInspiredCard()
                                .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Build a cocktail with Apple Intelligence")
                    }
        
                    HomeSection("Ingredients Ideas") {
                        IngredientGrid()
                            .padding(.horizontal)
                            .padding(.bottom, BarTinderApp.Padding.scrollViewVerticalSpacing)
                    }
                 
                    Spacer()
                }
                .navigationTitle("Home")
                .toolbar {
                    HomeToolbar(
                        sortOption: $model.sortOption,
                    )
                }
            }
            .barTinderDestinations()
        }
        .barTinderSheetDestinations()
        .environment(model)
    }
}

#Preview(traits: .queryMocks, .barTinderEnvironments) {
    Home()
}

private struct HomeSection<Content: View>: View {
    let title: String
    let content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .accessibilityAddTraits(.isHeader)
                Spacer()
            }
            .font(.system(size: 22, weight: .semibold, design: .rounded))
            .padding(.horizontal)
            .padding(.top, BarTinderApp.Padding.bigTitleSpacingTop)
            .padding(.bottom, title == "Your Cocktails" ? BarTinderApp.Padding.titleSpacingBottom : BarTinderApp.Padding.bigTitleSpacingBottom)
        }
        content
    }
}

