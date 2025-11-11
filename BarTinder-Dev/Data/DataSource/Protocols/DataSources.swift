/*
See the LICENSE file for this project's licensing information.

Abstract:
The Servable protocol used to mock data during the tests.
*/

import Foundation
import SwiftData

protocol Servable {
    func getAllCocktails() throws(NetworkErrors) -> [Cocktail]
}
