/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The DTOs for the network response.
*/

import Foundation

struct CocktailDTO: Decodable {
    let name: String
    let ingredients: [IngredientDTO]
    let style: String
    let glass: String
    let technique: String
    let difficulty: String
    let cocktailDescription: String
    let stock: Bool
  
}

struct IngredientDTO: Decodable {
    let name: String
    let measure: String
    let unit: String
}
