/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftData persistent model to store the ingredients of a cocktail.
*/

import Foundation
import SwiftData

@Model
final class Ingredient {
    var name: String
    var measure: String
    var unit: Units
    
    var cocktail: Cocktail?
    
    init(name: String = "", measure: String = "", unit: Units = Units.cl, cocktail: Cocktail? = nil) {
        self.name = name
        self.measure = measure
        self.unit = unit
        self.cocktail = cocktail
    }
}

