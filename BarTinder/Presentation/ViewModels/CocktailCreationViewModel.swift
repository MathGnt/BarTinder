//
//  CocktailCreationViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import Foundation
import SwiftData
import SwiftUI
import PhotosUI

@Observable
final class CocktailCreationViewModel {
    
    let useCase: CreationUseCase
    
    private(set) var ingredients: [Ingredient] = []
    private(set) var addedIngredients: [Ingredient] = []
    
    /// Picker / TF
    var selectedPic: PhotosPickerItem?
    var selectedUnit: [String : Units] = [:]
    var cocktailMeasure: [String : String] = [:]
    
    /// Alerts
    var textNotValid = false
    var ingredientsNotValid = false
    var photosError = false
    
    var searchableField = ""
    var searchableIngredients: [Ingredient] {
        if searchableField == "" {
            return ingredients
        } else {
            return ingredients.filter { $0.name.localizedStandardContains(searchableField)}
        }
    }

    init(useCase: CreationUseCase) {
        self.ingredients = Ingredient.ingredientCards
        self.useCase = useCase
    }
    
    func textFieldPlaceholder(for id: String) -> String {
        switch selectedUnit[id] ?? .cl {
        case .cl:
            return "Measure (in cl)"
        case .dash:
            return "Measure (in dashes)"
        case .drop:
            return "Measure (in drops)"
        case .pinch:
            return "Measure (in pinches)"
        case .wedge:
            return "Measure (in wedges)"
        case .topUp, .toRinse:
            return ""
        }
    }
    
    func imageDataToUI(_ cocktail: Cocktail) -> UIImage? {
        guard let data = cocktail.imageData else { return nil }
        return UIImage(data: data)
    }
    
    func addIngredient(ingredient: Ingredient) {
        guard !addedIngredients.contains(ingredient) else { return }
        addedIngredients.append(ingredient)
    }
    
    func removeIngredient(indices: IndexSet) {
        for index in indices {
            addedIngredients.remove(at: index)
        }
    }
    
    func haveToEnterMeasure(for ingredient: Ingredient) -> Bool {
        selectedUnit[ingredient.id] != .topUp && selectedUnit[ingredient.id] != .toRinse
    }
    
    func createIngredientsMeasures(_ cocktail: Cocktail) {
        do {
            cocktail.ingredientsMeasures = try useCase.makeIngredientMeasures(
                ingredients: addedIngredients,
                cocktailMeasure: cocktailMeasure,
                selectedUnit: selectedUnit
            )
        } catch CreationErrors.emptyFields {
            ingredientsNotValid = true
        } catch {
            print(error)
        }
    }
    
    func loadSelectedImage(_ cocktail: Cocktail) async {
        guard let selectedPic else { return }
        do {
            if let data = try await selectedPic.loadTransferable(type: Data.self) {
                cocktail.imageData = data
            }
        } catch {
            print("Image loading error: \(error.localizedDescription)")
        }
    }
    
    func validateFields(_ cocktail: Cocktail) -> Bool {
        guard !addedIngredients.isEmpty else {
            textNotValid = true
            return false
        }
        if !useCase.textValid(cocktail.abv, cocktail.cocktailDescription, cocktail.name, cocktail.flavor) {
            textNotValid = true
            return false
        }
        return true
    }
}

