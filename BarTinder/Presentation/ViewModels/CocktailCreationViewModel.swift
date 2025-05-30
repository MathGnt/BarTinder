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
    
    
    
    func addIngredient(ingredient: Ingredient) {
        guard !addedIngredients.contains(ingredient) else { return }
        addedIngredients.append(ingredient)
    }
    
    func removeIngredient(indices: IndexSet) {
        for index in indices {
            addedIngredients.remove(at: index)
        }
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
    
    enum CocktailStyle: String, Identifiable, CaseIterable {
        case longDrink = "longdrink"
        case shortDrink = "shortdrink"
        
        var id: String { self.rawValue }
    }
    
    enum CocktailGlass: String, Identifiable, CaseIterable {
        case balloon = "balloon"
        case cocktail = "cocktail"
        case coppermug = "coppermug"
        case highball = "highball"
        case tumbler = "tumbler"
        case flute = "flute"
        case hurricane = "hurricane"
        case wine = "wine"
        
        var id: String { self.rawValue }
    }
    
    enum CocktailPreparation: String, Identifiable, CaseIterable {
        case built = "built"
        case stirred = "stirred"
        case shaken = "shaken"
        case blended = "blended"
        case thrown = "thrown"
        case layered = "layered"
        
        var id: String { self.rawValue }
    }
    
    enum CocktailDifficulty: Int {
        case easy = 1
        case medium = 2
        case hard = 3
    }
    
    enum Units: String, CaseIterable, Identifiable {
        case cl = "cl"
        case dash = "Dash"
        case drop = "Drop"
        case pinch = "Pinch"
        case wedge = "Wedge"
        case topUp = "Top Up"
        case toRinse = "To Rinse"
        
        var id: String { self.rawValue }
    }
}
