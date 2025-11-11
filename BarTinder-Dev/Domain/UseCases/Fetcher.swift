/*
See the LICENSE file for this project's licensing information.

Abstract:
A use case that fetches all cocktails.
*/

import Foundation

struct Fetcher {
    private let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func execute() -> [Cocktail] {
        do {
            return try repo.getAllCocktails()
        } catch {
            print("Failed to get all cocktails from json")
            return []
        }
    }
}
