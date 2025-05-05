//
//  Cocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 17/04/2025.
//

import Foundation

struct CocktailResponse: Codable {
    let name: String
    let ingredients: [String]
    let measures: [String]
    let style: String
    let glass: String
    let preparation: String
    let abv: String
    let flavor: String
    let difficulty: Int
    let cocktailDescription: String
}

