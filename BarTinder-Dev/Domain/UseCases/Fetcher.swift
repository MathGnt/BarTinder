/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A use case that fetches all cocktails.
*/

import Foundation

struct Fetcher {
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func executeGetCocktails() -> [Cocktail] {
        do {
            return try repo.getAllCocktails()
        } catch {
            print("Failed to get all cocktails from json")
            return []
        }
    }
}
