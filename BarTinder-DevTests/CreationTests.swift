/*
See the LICENSE file for this project's licensing information.

Abstract:
The SwiftTesting file for cocktail & ingredients creation logic.
*/

import Testing
import SwiftData
@testable import BarTinder_Dev

@Suite("Creation")
struct CocktailCreationTests {
    let container: ModelContainer
    let context: ModelContext

    let useCase: CreationUseCase
    let cocktailModel: CocktailCreationModel
    let ingredientModel: IngredientCreationModel
    
    init() throws {
        self.container = try ModelContainer(for: Cocktail.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.context = ModelContext(container)
        
        self.useCase = CreationUseCase()
        self.cocktailModel = CocktailCreationModel(useCase: useCase)
        self.ingredientModel = IngredientCreationModel(useCase: useCase)
    }
    
    @Test("Should validate ingredients creation", .tags(.textFieldChecker), arguments: [Units.topUp, .toRinse])
    func ingredientsValidationFields(unit: Units) throws {
        let newCocktail = Cocktail(ingredients: [
            Ingredient(name: "tonic water", measure: "6", unit: .cl),
            Ingredient(name: "gin", measure: "12", unit: .cl),
            Ingredient(name: "lime", measure: "", unit: unit)
        ]
        )
        
        try ingredientModel.checkForIngredients(newCocktail.ingredients)
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
            try ingredientModel.checkForIngredients(newCocktail.ingredients)
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
        
        try cocktailModel.checkAndInsertCocktail(newCocktail)
    }
    
    @Test("Should throw empty cocktail-ingredients fields", .tags(.throwable), .disabled())
    func cocktailThrowingIngredientsFields() throws {
        let newCocktail = Cocktail(name: "Gin & Tonic", ingredients: [], cocktailDescription: "Enjoy this cocktail during summer")
        
        #expect(throws: CreationErrors.emptyCocktailFields) {
            try cocktailModel.checkAndInsertCocktail(newCocktail)
        }
    }
    
    @Test("Should throw empty general cocktail fields", .tags(.throwable, .textFieldChecker), arguments: [
        ("", "Gin Tonic", "13.2", "Sweet", CreationErrors.emptyCocktailFields),
        ("Gin & Tonic", "", "13.2", "Sweet", CreationErrors.emptyCocktailFields)
    ])
    func cocktailThrowingGeneralFields(name: String, description: String, abv: String, flavor: String, expectedError: CreationErrors) throws {
        let ingredients = [Ingredient(name: "tonic water", measure: "14", unit: .cl)]
        let newCocktail = Cocktail(name: name, ingredients: ingredients, cocktailDescription: description)
        
        #expect(throws: expectedError) {
            try cocktailModel.checkAndInsertCocktail(newCocktail)
        }
    }
    
    @Test("Should delete from base and remove possible from stock", arguments: [
        true, false
    ])
    func correctDeleting(isStock: Bool) throws {
        let newCocktail = Cocktail(stock: isStock)
        context.insert(newCocktail)
        context.contextDelete(newCocktail)
        
        let cocktails = context.getContent(for: Cocktail.self)
        
        let expected = isStock ?
            cocktails.filter { $0.isPossible == false }.contains { $0.id == newCocktail.id } :
            !cocktails.contains { $0.id == newCocktail.id }
        
        #expect(expected)
    }
}

