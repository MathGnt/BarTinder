/*
See the LICENSE file for this project's licensing information.

Abstract:
A view modifier that handles the BarTinder destinations.
*/

import Foundation
import SwiftUI

struct SheetDestinations: ViewModifier {
    @Environment(\.router) private var router
    @Environment(\.modelContext) private var context

    func body(content: Content) -> some View {
        @Bindable var router = router

        content
            .sheet(item: $router.presentedSheet) { sheetState in
                @Bindable var sheetState = sheetState

                NavigationStack(path: $sheetState.path) {
                    sheetView(for: sheetState.root)
                        .navigationDestination(for: SheetDestination.self) { destination in
                            sheetView(for: destination)
                        }
                }
            }
    }

    @ViewBuilder
    private func sheetView(for destination: SheetDestination) -> some View {
        switch destination {
        case .cocktailDetail(let cocktail):
            CocktailDetail(cocktail: cocktail)
        case .cocktailEdit(let cocktail):
            CreateEditCocktail(cocktail: cocktail)
                .environment(\.modelContext, cocktail.modelContext!)
                .interactiveDismissDisabled()
        case .ingredientsEdit(let cocktail):
            IngredientsListCreation(cocktail: cocktail)
        case .askedForCocktail:
            GetInspired()
        }
    }
}

extension View {
    func barTinderSheetDestinations() -> some View {
        modifier(SheetDestinations())
    }
}
