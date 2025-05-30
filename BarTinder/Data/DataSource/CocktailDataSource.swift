//
//  CocktailDataSource.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 19/04/2025.
//

import Foundation

final class CocktailDataSource { /// Controlling the JSON entry
    
    func getCocktails() throws -> [CocktailDTO] {
        guard let url = Bundle.main.url(forResource: "cocktails", withExtension: "json") else {
            throw URLError(.badURL)
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([CocktailDTO].self, from: data)
            return decodedData
        } catch {
            throw URLError(.cannotParseResponse)
        }
    }
}

