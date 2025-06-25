//
//  Cocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 17/04/2025.
//

import Foundation

struct CocktailDTO: Decodable {
    let name: String
    let ingredients: [IngredientDTO]
    let style: String
    let glass: String
    let technique: String
    let abv: String
    let flavor: String
    let difficulty: Int
    let cocktailDescription: String
    let stock: Bool
  
}

struct IngredientDTO: Decodable {
    let name: String
    let measure: String
    let unit: String
}
