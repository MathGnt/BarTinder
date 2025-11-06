/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The SwiftTesting file for the swiping and matching logic.
*/

import Testing
import SwiftData
@testable import BarTinder_Dev

@Suite("Swiping")
struct SwipeTests {
    let container: ModelContainer
    let context: ModelContext
    let repo: RepositoryMock
    
    init() throws {
        self.container = try ModelContainer(for: Cocktail.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.context = ModelContext(container)
        self.repo = RepositoryMock()
    }
    
    @Test("Should return correct cocktails after swiping cards")
    func correctCocktailsAfterSwipe() throws {
        let useCase = Fetcher(repo: repo)
        let model = IngredientsModel()
        
        for cocktail in useCase.executeGetCocktails() {
            context.insert(cocktail)
        }
        
        let swipedRightIngredients: [CardIngredient] = [
            .init(image: "mint", name: "mint", otherName: nil, abv: nil, location: "Mediterranean Region", summer: true, unit: "Leaf"),
            .init(image: "tequila", name: "tequila", otherName: nil, abv: "38", location: "Mexico", summer: false, unit: "Cl"),
            .init(image: "sparkling", name: "sparkling water", otherName: nil, abv: nil, location: "Switzerland", summer: true, unit: "Cl"),
            .init(image: "lime", name: "lime", otherName: "lime juice", abv: nil, location: "Malaysia", summer: true, unit: "Cl"),
            .init(image: "syrup", name: "sugar cane syrup", otherName: nil, abv: nil, location: "Caribbean", summer: false, unit: "Cl"),
            .init(image: "cointreau", name: "triple sec", otherName: nil, abv: "40", location: "France", summer: false, unit: "Cl"),
            .init(image: "whiskey", name: "whisky", otherName: nil, abv: "40", location: "Scotland", summer: false, unit: "Cl"),
            .init(image: "vodka", name: "vodka", otherName: nil, abv: "40", location: "Russia", summer: true, unit: "Cl"),
            .init(image: "cranberryjuice", name: "cranberry juice", otherName: nil, abv: nil, location: "United States", summer: false, unit: "Cl"),
            .init(image: "syrup", name: "sugar cane syrup", otherName: nil, abv: nil, location: "Caribbean", summer: false, unit: "Cl"),
        ]
        
        for selectedIngredient in swipedRightIngredients {
            model.addIngredient(selectedIngredient)
        }
        
        model.updatePossibleCocktails(cocktails: context.getContent(for: Cocktail.self))

        let possibleCocktails = context.getContent(for: Cocktail.self).filter(\.isPossible).map(\.name).sorted()
        let isSuperset = Set(possibleCocktails) == Set(["Cosmopolitan", "Margarita"])
        
        #expect(isSuperset, "Expected only Margarita and Cosmopolitan as possible cocktails, got: \(possibleCocktails)")
        
    }
}
