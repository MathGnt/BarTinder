/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The Servable protocol used to mock data during the tests.
*/

import Foundation
import SwiftData

protocol Servable {
    func getAllCocktails() throws(NetworkErrors) -> [Cocktail]
}
