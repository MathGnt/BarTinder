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
                    
                    sectionTitle(title: "Your Cocktails")
                    YourCocktailsScrollView(model: model)
                        .padding(.horizontal)
                        .padding(.bottom, BarTinderApp.Padding.scrollViewVerticalSpacing)
                    
                    sectionTitle(title: "Get inspired")
                    Button {
                        router.presentSheet(.askedForCocktail)
                    } label: {
                        GetInspiredCard()
                            .padding(.horizontal)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Build a cocktail with AI")
                    
                    sectionTitle(title: "Summer Ideas Ingredients")
                    IngredientGrid()
                        .padding(.horizontal)
                        .padding(.bottom, BarTinderApp.Padding.scrollViewVerticalSpacing)
                    
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
            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0), value: model.showNewIdeaSheet)
        }
        .barTinderSheetDestinations()
        .environment(model)
    }
}

#Preview(traits: .queryMocks) {
    Home()
        .environment(Router())
}


//MARK: - Small components

private extension Home {
    func sectionTitle(title: String) -> some View {
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
}
