/*
See the LICENSE file for this project's licensing information.

Abstract:
A network call to the cocktail.json file that decodes all the cocktails.
*/

import Foundation

final class CocktailDataSource {
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

