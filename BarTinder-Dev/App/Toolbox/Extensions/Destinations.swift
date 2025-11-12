/*
See the LICENSE file for this project's licensing information.

Abstract:
The navigationDestination modifiers for BarTinder.
*/

import Foundation
import SwiftUI

extension View {
    func barTinderDestinations() -> some View {
        self
            .navigationDestination(for: RouterDestination.self) { destination in
                switch destination {
                case .cocktailDetail(let cocktail, let namespace):
                    if let namespace {
                        CocktailDetail(cocktail: cocktail)
                            .navigationTransition(.zoom(sourceID: cocktail.id, in: namespace))
                    } else {
                        CocktailDetail(cocktail: cocktail)
                    }
                case .cocktailList(let ingredient):
                    IngredientMatcher(ingredientCard: ingredient)
                case .generatedCocktail:
                    GeneratedCocktail()
                case .bar:
                    Bar()
                }
            }
    }
}
