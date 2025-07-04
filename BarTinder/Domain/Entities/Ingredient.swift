//
//  Ingredient.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/06/2025.
//

import Foundation
import SwiftData

@Model
nonisolated final class Ingredient {
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


