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
@MainActor
final class CocktailCreationViewModel {
    
    let useCase: CreationUseCase
    
    private(set) var ingredients: [Ingredient] = []
    private(set) var addedIngredients: [Ingredient] = []
    private var ingredientsMeasures: [IngredientMeasure] = []
    
    /// Picker / TF
    var cocktailName = ""
    var cocktailDescription = ""
    var addToBar = false
    var selectedPic: PhotosPickerItem?
    private(set) var selectedImage: Data?
    var cocktailAbv = ""
    var cocktailFlavor = ""
    var cocktailStyle: CocktailStyle = .shortDrink
    var cocktailPreparation: CocktailPreparation = .built
    var cocktailGlass: CocktailGlass = .highball
    var cocktailDifficulty: CocktailDifficulty = .easy
    var selectedUnit: [String : Units] = [:]
    var cocktailMeasure: [String : String] = [:]
    var searchableField = ""
    var notValid = false
    var ingredientsNotValid = false
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
    
    func imageDataToUI() -> UIImage? {
        guard let data = selectedImage else { return nil }
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
    
    func createIngredientsMeasures() {
        do {
            self.ingredientsMeasures = try useCase.makeIngredientMeasures(
                ingredients: addedIngredients,
                cocktailMeasure: cocktailMeasure,
                selectedUnit: selectedUnit
            )
        } catch CUCErrors.emptyFields {
            ingredientsNotValid = true
        } catch {
            print(error)
        }
    }
    
    func loadSelectedImage() async {
        guard let selectedPic else { return }
        do {
            if let data = try await selectedPic.loadTransferable(type: Data.self) {
                selectedImage = data
            }
        } catch {
            print("Erreur de chargement de l'image: \(error.localizedDescription)")
        }
    }
    
    func createCocktail() {
        
        guard useCase.textValid(cocktailName, cocktailDescription, cocktailAbv, cocktailFlavor),
              !ingredientsMeasures.isEmpty else {
            notValid = true
            return
        }
        
        let newCocktail = Cocktail(
            name: cocktailName,
            ingredientsMeasures: ingredientsMeasures,
            isInBar: addToBar,
            isPossible: true,
            imageName: nil,
            imageData: selectedImage,
            style: cocktailStyle.rawValue,
            glass: cocktailGlass.rawValue,
            preparation: cocktailPreparation.rawValue,
            abv: cocktailAbv,
            flavor: cocktailFlavor,
            difficulty: cocktailDifficulty.rawValue,
            cocktailDescription: cocktailDescription,
            stock: false
        )
        
        useCase.createNewCocktail(newCocktail)
    }
    
}

