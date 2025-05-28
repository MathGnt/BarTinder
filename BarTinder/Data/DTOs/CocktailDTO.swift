//
//  Cocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 17/04/2025.
//

import Foundation

struct CocktailDTO: Decodable {
    let name: String
    let ingredientsMeasures: [IngredientMeasureDTO]
    let style: String
    let glass: String
    let preparation: String
    let abv: String
    let flavor: String
    let difficulty: Int
    let cocktailDescription: String
    let stock: Bool
  
}

struct IngredientMeasureDTO: Decodable {
    let ingredient: String
    let measure: String
}
