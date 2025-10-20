//
//  SwipeTests.swift
//  SwipeTests
//
//  Created by Mathis Gaignet on 20/05/2025.
//

import Testing
import SwiftData
@testable import BarTinder

@Suite("Swiping")
struct SwipeTests {
    let container: ModelContainer
    let context: ModelContext
    let swiftData: SwiftDataSource
    let repo: RepositoryMock
    
    init() throws {
        self.container = try ModelContainer(for: Cocktail.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.context = ModelContext(container)
        
        self.swiftData = SwiftDataSource(context: context)
        self.repo = RepositoryMock(swiftDataSource: swiftData)
    }
    
    @Test("Should return correct cocktails after swiping cards")
    func correctCocktailsAfterSwipe() throws {
        let useCase = SwipeUseCase(repo: repo)
        let model = SwipeModel(useCase: useCase)
        
        model.getCocktails()
        
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

        let possibleCocktails = swiftData.getContextContent(Cocktail.self).filter(\.isPossible).map(\.name).sorted()
        
        let isSuperset = Set(possibleCocktails) == Set(["Cosmopolitan", "Margarita"])
        
        #expect(isSuperset, "Expected only Margarita and Cosmopolitan as possible cocktails, got: \(possibleCocktails)")
        
    }
}
