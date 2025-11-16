/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view that serves as the main screen of the app.
*/

import SwiftUI
import SwiftData

struct Home: View {
    @Environment(\.modelContext) private var context
    @Environment(\.router) private var router
    @State private var model = HomeModel()
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.navigationPaths) {
            ScrollView {
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(CocktailFilterPredicate.allCases, id: \.self) { filter in
                                GlassEffectContainer {
                                    SortingButton(title: filter.rawValue, filterOption: filter)
                                }
                            }
                        }
                    }
                    .scrollClipDisabled()
                    .scrollIndicators(.hidden)
                    
                    HomeSection("Your Cocktails") {
                        YourCocktailsScrollView(descriptor: model.yourCocktailsDescriptor)

                    }
                    
                    HomeSection("Get Inspired") {
                        Button {
                            router.presentSheet(.askedForCocktail)
                        } label: {
                            GetInspiredCard()
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Build a cocktail with Apple Intelligence")
                    }
        
                    HomeSection("Ingredients Ideas") {
                        IngredientGrid()
                            .padding(.bottom, BarTinderApp.Padding.scrollViewVerticalSpacing)
                    }
                 
                    Spacer()
                }
                .padding(.horizontal)
                .navigationTitle("Home")
                .toolbar {
                    HomeToolbar()
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

extension Home {
    struct HomeSection<Content: View>: View {
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
                .padding(.top, BarTinderApp.Padding.titleSpacingTop)
            }
            content
        }
    }
}
