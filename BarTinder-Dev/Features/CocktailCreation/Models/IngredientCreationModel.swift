/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An observable model that manages ingredient selection and validation during cocktail creation.
*/

import Foundation

@Observable
final class IngredientCreationModel {
    let useCase: CreationUseCase
    
    private(set) var ingredients: [CardIngredient] = []
    var searchableField = ""
    var measuresFieldMissing = false
    
    var searchableIngredients: [CardIngredient] {
        guard !searchableField.isEmpty else { return ingredients }
        return ingredients.filter {
            $0.name.localizedStandardContains(searchableField)
        }
    }
    
    init(useCase: CreationUseCase = CreationUseCase()) {
        self.useCase = useCase
        self.ingredients = CardIngredient.ingredientCards
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
        guard !ingredients.isEmpty else {
            measuresFieldMissing = true
            throw .emptyMeasuresFields
        }
        try useCase.executeIngredientsChecking(ingredients)
    }
}
