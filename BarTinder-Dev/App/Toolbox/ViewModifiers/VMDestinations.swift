/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A view modifier that handles the BarTinder destinations.
*/

import Foundation
import SwiftUI

struct SheetDestinations: ViewModifier {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var context
    @State private var inspiredDetent: PresentationDetent = .height(260)
    
    func body(content: Content) -> some View {
        @Bindable var router = router
        
        content
            .sheet(item: $router.presentedSheet) { sheet in
                NavigationStack(path: $router.sheetPaths) {
                    Group {
                        switch sheet {
                        case .cocktailDetail(let cocktail):
                            CocktailDetail(cocktail: cocktail)
                        case .cocktailEdit(let cocktail):
                            CreateEditCocktail(cocktail: cocktail)
                                .environment(\.modelContext, cocktail.modelContext!)
                                .interactiveDismissDisabled()
                        case .ingredientsEdit(let cocktail):
                            IngredientsListCreation(cocktail: cocktail)
                        case .askedForCocktail:
                            GetInspired(inspiredDetent: $inspiredDetent)
                                .presentationDetents([.height(260), .large], selection: $inspiredDetent)
                        }
                    }
                    .innerSheetDestination()
                }
            }
    }
}

extension View {
    func barTinderSheetDestinations() -> some View {
        modifier(SheetDestinations())
    }
}
