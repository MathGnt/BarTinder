//
//  CreationTests.swift
//  BarTinderTests
//
//  Created by Mathis Gaignet on 11/07/2025.
//

import Testing
import SwiftData
@testable import BarTinder

@Suite("Creation")
struct CocktailCreationTests {
    let container: ModelContainer
    let context: ModelContext
    
    let swiftData: SwiftDataSource
    let repo: RepositoryMock
    let useCase: CreationUseCase
    let model: CreationModel
    
    init() throws {
        self.container = try ModelContainer(for: Cocktail.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.context = ModelContext(container)
        
        self.swiftData = SwiftDataSource(context: context)
        self.repo = RepositoryMock(swiftDataSource: swiftData)
        self.useCase = CreationUseCase(repo: repo)
        self.model = CreationModel(useCase: useCase)
    }
    
    @Test("Should validate ingredients creation", .tags(.textFieldChecker), arguments: [Units.topUp, .toRinse])
    func ingredientsValidationFields(unit: Units) throws {
        let newCocktail = Cocktail(ingredients: [
            Ingredient(name: "tonic water", measure: "6", unit: .cl),
            Ingredient(name: "gin", measure: "12", unit: .cl),
            Ingredient(name: "lime", measure: "", unit: unit)
        ]
        )
        
        try model.checkForIngredients(newCocktail.ingredients)
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
            try model.checkForIngredients(newCocktail.ingredients)
        }
    }
    
    @Test("Should validate cocktail creation", .tags(.textFieldChecker))
    func cocktailValidationFields() throws {
        let ingredients: [Ingredient] = [
            Ingredient(name: "tonic water", measure: "14", unit: .cl),
            Ingredient(name: "gin", measure: "12", unit: .cl),
            Ingredient(name: "lime", measure: "1", unit: .wedge)
        ]
        
        let newCocktail = Cocktail(name: "Gin Tonic", ingredients: ingredients, cocktailDescription: "Enjoy this cocktail during summer")
        
        try model.checkAndInsertCocktail(newCocktail)
    }
    
    @Test("Should throw empty cocktail-ingredients fields", .tags(.throwable))
    func cocktailThrowingIngredientsFields() throws {
        let newCocktail = Cocktail(name: "Gin & Tonic", ingredients: [], cocktailDescription: "Enjoy this cocktail during summer")
        
        #expect(throws: CreationErrors.emptyCocktailFields(.measure)) {
            try model.checkAndInsertCocktail(newCocktail)
        }
    }
    
    @Test("Should throw empty general cocktail fields", .tags(.throwable, .textFieldChecker), arguments: [
        ("", "Gin Tonic", "13.2", "Sweet", CreationErrors.emptyCocktailFields(.name)),
        ("Gin & Tonic", "", "13.2", "Sweet", CreationErrors.emptyCocktailFields(.description))
    ])
    func cocktailThrowingGeneralFields(name: String, description: String, abv: String, flavor: String, expectedError: CreationErrors) throws {
        let ingredients = [Ingredient(name: "tonic water", measure: "14", unit: .cl)]
        let newCocktail = Cocktail(name: name, ingredients: ingredients, cocktailDescription: description)
        
        #expect(throws: expectedError) {
            try model.checkAndInsertCocktail(newCocktail)
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

