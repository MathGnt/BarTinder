//
//  BarTinderTests.swift
//  BarTinderTests
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
        let viewModel = SwipeViewModel(useCase: useCase)
        
        viewModel.getCocktails()
        
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
            viewModel.addIngredient(selectedIngredient)
        }

        let possibleCocktails = swiftData.getContextContent(Cocktail.self).filter(\.isPossible).map(\.name).sorted()
        
        let isSuperset = Set(possibleCocktails) == Set(["Cosmopolitan", "Margarita"])
        
        #expect(isSuperset, "Expected only Margarita and Cosmopolitan as possible cocktails, got: \(possibleCocktails)")
        
    }
}


@Suite("Creation")
struct CocktailCreationTests {
    
    let container: ModelContainer
    let context: ModelContext
    
    let swiftData: SwiftDataSource
    let repo: RepositoryMock
    let useCase: CreationUseCase
    let viewModel: CocktailCreationViewModel
    
    init() throws {
        self.container = try ModelContainer(for: Cocktail.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.context = ModelContext(container)
        
        self.swiftData = SwiftDataSource(context: context)
        self.repo = RepositoryMock(swiftDataSource: swiftData)
        self.useCase = CreationUseCase(repo: repo)
        self.viewModel = CocktailCreationViewModel(useCase: useCase)
    }
    
    @Test("Should validate ingredients creation", .tags(.textFieldChecker), arguments: [Units.topUp, .toRinse])
    func ingredientsValidationFields(unit: Units) throws {
        
        let newCocktail = Cocktail(ingredients: [
            Ingredient(name: "tonic water", measure: "6", unit: .cl),
            Ingredient(name: "gin", measure: "12", unit: .cl),
            Ingredient(name: "lime", measure: "", unit: unit)
        ]
        )
        
        try viewModel.checkForIngredients(newCocktail.ingredients)
    }

    @Test("Should throw empty measures", .tags(.throwable, .textFieldChecker), arguments: ["    ", ""])
    func ingredientsThrowingFields(invalideMeasure: String) throws {
        
        let newCocktail = Cocktail(ingredients: [
            Ingredient(name: "tonic water", measure: invalideMeasure, unit: .cl),
            Ingredient(name: "gin", measure: "12", unit: .cl),
            Ingredient(name: "lime", measure: "1", unit: .wedge)
        ]
        )
        
        #expect(throws: CreationErrors.emptyMeasuresFields) {
            try viewModel.checkForIngredients(newCocktail.ingredients)
        }
    }
    
    @Test("Should validate cocktail creation", .tags(.textFieldChecker))
    func cocktailValidationFields() throws {
        
        let ingredients: [Ingredient] = [
            Ingredient(name: "tonic water", measure: "14", unit: .cl),
            Ingredient(name: "gin", measure: "12", unit: .cl),
            Ingredient(name: "lime", measure: "1", unit: .wedge)
        ]
        
        let newCocktail = Cocktail(name: "Gin Tonic", ingredients: ingredients, abv: "13.2", flavor: "Sweet", cocktailDescription: "Enjoy this cocktail during summer")
        
        try viewModel.checkAndInsertCocktail(newCocktail)
    }
    
    @Test("Should throw empty cocktail-ingredients fields", .tags(.throwable))
    func cocktailThrowingIngredientsFields() throws {

        let newCocktail = Cocktail(name: "Gin & Tonic", ingredients: [], abv: "13.2", flavor: "Sweet", cocktailDescription: "Enjoy this cocktail during summer")
        
        #expect(throws: CreationErrors.emptyCocktailFields(.measure)) {
            try viewModel.checkAndInsertCocktail(newCocktail)
        }
    }
    
    @Test("Should throw empty general cocktail fields", .tags(.throwable, .textFieldChecker), arguments: [
        ("", "Gin Tonic", "13.2", "Sweet", CreationErrors.emptyCocktailFields(.name)),
        ("Gin & Tonic", "", "13.2", "Sweet", CreationErrors.emptyCocktailFields(.description)),
        ("Gin & Tonic", "Gin Tonic", "", "Sweet", CreationErrors.emptyCocktailFields(.abv)),
        ("Gin & Tonic", "Gin Tonic", "13.2", "", CreationErrors.emptyCocktailFields(.flavor))
    ])
    func cocktailThrowingGeneralFields(name: String, description: String, abv: String, flavor: String, expectedError: CreationErrors) throws {
        
        let ingredients = [Ingredient(name: "tonic water", measure: "14", unit: .cl)]
        let newCocktail = Cocktail(name: name, ingredients: ingredients, abv: abv, flavor: flavor, cocktailDescription: description)
        
        #expect(throws: expectedError) {
            try viewModel.checkAndInsertCocktail(newCocktail)
        }
    }
    
    @Test("Should delete from base and remove possible from stock", arguments: [
        true, false
    ])
    func correctDeleting(isStock: Bool) throws {
        
        let newCocktail = Cocktail(stock: isStock)
        swiftData.contextInsert(newCocktail)
        swiftData.contextDelete(newCocktail)
        
        let cocktails = swiftData.getContextContent(Cocktail.self)
        
        let expected = isStock ? 
            cocktails.filter { $0.isPossible == false }.contains { $0.id == newCocktail.id } :
            !cocktails.contains { $0.id == newCocktail.id }
        
        #expect(expected)
    }
}

