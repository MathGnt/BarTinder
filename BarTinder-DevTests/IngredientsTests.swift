/*
See the LICENSE file for this project's licensing information.

Abstract:
The SwiftTesting file for the ingredients sorting logic.
*/

import Foundation
import Testing
@testable import BarTinder_Dev

@Suite("Ingredients")
struct IngredientsTests {
    let model = IngredientCreationModel()
    
    @Test("Should return searched ingredient")
    func searchedIngredient() {
        model.searchableField = "co"
        
        let searchedIngredients: [CardIngredient] = [
            .init(image: "cognac", name: "cognac", otherName: [], abv: "40", location: "France", summer: false, unit: "Cl"),
            .init(image: "cococream", name: "coco cream", otherName: [], abv: nil, location: "Philippines", summer: false, unit: "Cl"),
            .init(image: "coke", name: "coke", otherName: [], abv: nil, location: "United States", summer: false, unit: "Cl"),
            .init(image: "coffeeliqueur", name: "coffee liqueur", otherName: [], abv: "20", location: "Mexico", summer: false, unit: "Cl"),
            .init(image: "tabasco", name: "tabasco sauce", otherName: [], abv: nil, location: "United States", summer: false, unit: "Drop"),
            .init(image: "prosecco", name: "prosecco", otherName: [], abv: "11", location: "Italy", summer: true, unit: "Cl"),
        ]
        
        #expect(Set(model.searchableIngredients) == Set(searchedIngredients))
    }
}
