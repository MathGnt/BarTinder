//
//  NetworkManager.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 19/04/2025.
//

import Foundation

class NetworkManager {
    
    func getCocktails() throws -> [Cocktail] {
        guard let url = Bundle.main.url(forResource: "cocktails", withExtension: "json") else {
            throw URLError(.badURL)
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([Cocktail].self, from: data)
            return decodedData
        } catch {
            throw URLError(.cannotParseResponse)
        }
    }
}

enum NetworkErrors: LocalizedError {
    case couldntFetchCocktails
    
    var errorDescription: String? {
        switch self {
        case .couldntFetchCocktails:
            return "Couldn't fetch cocktails list"
        }
    }
}
