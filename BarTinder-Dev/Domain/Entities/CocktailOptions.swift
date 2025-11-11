/*
See the LICENSE file for this project's licensing information.

Abstract:
A file gathering all the cocktail options available as a picker for the user.
*/

import Foundation

enum CocktailStyle: String, Identifiable, CaseIterable, Codable {
    case longDrink = "long drink"
    case shortDrink = "short drink"
    
    var id: String { self.rawValue }
}

enum CocktailGlass: String, Identifiable, CaseIterable, Codable {
    case balloon = "balloon"
    case cocktail = "cocktail"
    case coppermug = "coppermug"
    case highball = "highball"
    case tumbler = "tumbler"
    case flute = "flute"
    case hurricane = "hurricane"
    case wine = "wine"
    
    var id: String { self.rawValue }
}

enum CocktailMixingTechnique: String, Identifiable, CaseIterable, Codable {
    case built = "built"
    case stirred = "stirred"
    case shaken = "shaken"
    case blended = "blended"
    case thrown = "thrown"
    case layered = "layered"
    
    var id: String { self.rawValue }
}

enum CocktailDifficulty: String, Codable, CaseIterable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    
    var level: Int {
        switch self {
        case .easy:
            1
        case .medium:
            2
        case .hard:
            3
        }
    }
}

enum Units: String, CaseIterable, Identifiable, Codable {
    case cl = "cl"
    case dash = "Dash"
    case drop = "Drop"
    case pinch = "Pinch"
    case wedge = "Wedge"
    case topUp = "Top Up"
    case toRinse = "To Rinse"
    
    var id: String { self.rawValue }
    
    var needsMeasure: Bool {
        switch self {
        case .topUp, .toRinse:
            return false
        default:
            return true
        }
    }
}
