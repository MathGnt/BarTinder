//
//  Errors.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import Foundation


enum NetworkErrors: Error {
    case couldntMapCocktails
    case failedToGetCocktails
}

enum CUCErrors: Error {
    case emptyFields
}
