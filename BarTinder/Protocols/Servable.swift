//
//  Servable.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/05/2025.
//

import Foundation

protocol Servable {
    func getAllCocktails() throws -> [Cocktail]
}
