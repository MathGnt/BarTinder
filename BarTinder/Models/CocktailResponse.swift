//
//  Cocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 17/04/2025.
//

import Foundation

struct CocktailResponse: Decodable {
    let name: String
    let ingredientsMeasures: [IngredientMeasureResponse]
    let style: String
    let glass: String
    let preparation: String
    let abv: String
    let flavor: String
    let difficulty: Int
    let cocktailDescription: String
  
}

struct IngredientMeasureResponse: Decodable {
    let ingredient: String
    let measure: String
}
