//
//  BarTinderTests.swift
//  BarTinderTests
//
//  Created by Mathis Gaignet on 20/05/2025.
//

import Testing
import SwiftData
@testable import BarTinder

@MainActor
class BarTinderTests {
    
    @Test("Should return correct cocktails after swiping cards")
    func correctCocktails() async throws {
        
        /// Swift Data setup
        let container = try ModelContainer(for: Cocktail.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = ModelContext(container)
        
        let swiftData = SwiftDataSource(context: context)
        let repo = RepositoryMock(swiftDataSource: swiftData)
        let useCase = SwipeUseCase(repo: repo)
        let viewModel = SwipeViewModel(useCase: useCase)
        
 
        
        viewModel.getCocktails()
        
        let ingredients: [Ingredient] = [
            .init(image: "mint", name: "mint", otherName: nil, AVB: nil, location: "Mediterranean Region", summer: true, unit: "Leaf"),
            .init(image: "tequila", name: "tequila", otherName: nil, AVB: "38", location: "Mexico", summer: false, unit: "Cl"),
            .init(image: "sparkling", name: "sparkling water", otherName: nil, AVB: nil, location: "Switzerland", summer: true, unit: "Cl"),
            .init(image: "lime", name: "lime", otherName: "lime juice", AVB: nil, location: "Malaysia", summer: true, unit: "Cl"),
            .init(image: "syrup", name: "sugar cane syrup", otherName: nil, AVB: nil, location: "Caribbean", summer: false, unit: "Cl"),
            .init(image: "cointreau", name: "triple sec", otherName: nil, AVB: "40", location: "France", summer: false, unit: "Cl"),
            .init(image: "whiskey", name: "whisky", otherName: nil, AVB: "40", location: "Scotland", summer: false, unit: "Cl"),
            .init(image: "vodka", name: "vodka", otherName: nil, AVB: "40", location: "Russia", summer: true, unit: "Cl"),
            .init(image: "cointreau", name: "triple sec", otherName: nil, AVB: "40", location: "France", summer: false, unit: "Cl"),
            .init(image: "cranberryjuice", name: "cranberry juice", otherName: nil, AVB: nil, location: "United States", summer: false, unit: "Cl"),
            .init(image: "syrup", name: "sugar cane syrup", otherName: nil, AVB: nil, location: "Caribbean", summer: false, unit: "Cl"),
        ]
        
        for selectedIngredient in ingredients {
            viewModel.addIngredient(selectedIngredient)
        }
        
        let descriptor = FetchDescriptor<Cocktail>()
        let results = try context.fetch(descriptor)
        
        let possibleCocktails = results.filter(\.isPossible).map(\.name)
        #expect(Set(possibleCocktails) == Set(["Margarita", "Cosmopolitan"]), "Expected only Margarita and Cosmopolitan as possible cocktails, got: \(possibleCocktails)")
        
    }
    
}
