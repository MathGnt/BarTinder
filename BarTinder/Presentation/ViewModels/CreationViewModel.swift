//
//  CreationViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import Foundation
import SwiftData
import SwiftUI
import PhotosUI

@Observable
final class CreationViewModel {
    let useCase: CreationUseCase
    
    private(set) var ingredients: [CardIngredient] = []

    var selectedPic: PhotosPickerItem?
    var searchableField = ""
    var searchableIngredients: [CardIngredient] {
        guard !searchableField.isEmpty else { return ingredients }
        return ingredients.filter {
            $0.name.localizedStandardContains(searchableField)
        }
    }
    
    /// Toolbar
    var showIngredientsSheet = false
    var currentIngredientsState: [Ingredient] = []
    var missingFocus: Focus?
    
    /// Alerts & confirmations
    var generalCocktailFieldsMissing = false
    var measuresFieldMissing = false
    var photosError = false
    var askForDiscard = false
    
    init(useCase: CreationUseCase) {
        self.ingredients = CardIngredient.ingredientCards
        self.useCase = useCase
    }
    
    func textFieldPlaceholder(_ selectedUnit: Units) -> String {
        switch selectedUnit {
        case .cl:
            return "(in cl)"
        case .dash:
            return "(in dashes)"
        case .drop:
            return "(in drops)"
        case .pinch:
            return "(in pinches)"
        case .wedge:
            return "(in wedges)"
        case .topUp, .toRinse:
            return ""
        }
    }
    
    func imageDataToUI(_ cocktail: Cocktail) -> UIImage? {
        guard let data = cocktail.imageData else { return nil }
        return UIImage(data: data)
    }
    
    
    func loadSelectedImage(_ cocktail: Cocktail) async {
        guard let selectedPic else { return }
        do {
            if let data = try await selectedPic.loadTransferable(type: Data.self) {
                cocktail.imageData = data
            }
        } catch {
            photosError = true
            print("Image loading error: \(error.localizedDescription)")
        }
    }
    
    func addIngredient(_ cocktail: Cocktail, _ ingredient: CardIngredient) {
        let newIngredient: Ingredient = Ingredient(name: ingredient.name, measure: "", unit: .cl)
        cocktail.ingredients.append(newIngredient)
    }
    
    
    func removeIngredient(indexSet: IndexSet, _ cocktail: Cocktail) {
        for index in indexSet {
            cocktail.ingredients.remove(at: index)
        }
    }
    
    func removeMeasure(_ ingredient: Ingredient, _ newValue: Units) {
        if newValue == .topUp || newValue == .toRinse {
            ingredient.measure = ""
        }
    }
    
    func checkForIngredients(_ ingredients: [Ingredient]) throws(CreationErrors) {
        try useCase.executeIngredientsChecking(ingredients)
    }
    
    func checkAndInsertCocktail(_ cocktail: Cocktail) throws(CreationErrors) {
        try useCase.executeCocktailChecking(cocktail)
        useCase.createNewCocktail(cocktail)
    }
}

