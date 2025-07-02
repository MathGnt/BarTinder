//
//  CocktailOptions.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/06/2025.
//

import Foundation

/// Filtering, Sorting and Ordering @Query
enum CocktailSortDescriptor: String, CaseIterable {
    case name = "Name"
    case difficulty = "Difficulty"
    case glass = "Glass"
    case technique = "Technique"
    
    func sortDescriptor(reversed: Bool) -> [SortDescriptor<Cocktail>] {
        let order: SortOrder = reversed ? .reverse : .forward
        return switch self {
        case .name:
            [SortDescriptor(\Cocktail.name, order: order)]
        case .difficulty:
            [SortDescriptor(\Cocktail.difficultyValue, order: order),
             SortDescriptor(\Cocktail.name, order: .forward)]
        case .glass:
            [SortDescriptor(\Cocktail.glassValue, order: order),
             SortDescriptor(\Cocktail.name, order: .forward)]
        case .technique:
            [SortDescriptor(\Cocktail.mixingTechniqueValue, order: order),
             SortDescriptor(\Cocktail.name, order: .forward)]
        }
    }
}

enum CocktailFilterPredicate: String, CaseIterable, Hashable {
    case possibleCocktails = "All cocktails"
    case created = "Created"
    case gin = "Gin"
    case vodka = "Vodka"
    case vermouth = "Vermouth"
    case whisky = "Whisky"
    case shortDrink = "Short Drinks"
    case longDrink = "Long Drinks"
    
    /// Static filtering
    static func byIngredient(_ ingredient: CardIngredient) -> Predicate<Cocktail> {
        let name = ingredient.name
        return #Predicate<Cocktail> {
            $0.ingredients.contains { $0.name == name }
        }
    }
    
    static var byInBar: Predicate<Cocktail> {
        #Predicate<Cocktail> {
            $0.isInBar
        }
    }
    
    /// Dynamic filtering
    var filterPredicate: Predicate<Cocktail> {
    
        switch self {
        case .possibleCocktails:
            return #Predicate<Cocktail> { $0.isPossible }
        case .created:
            return #Predicate<Cocktail> { $0.stock == false }
        case .gin:
            return #Predicate<Cocktail> { cocktail in
                cocktail.isPossible &&
                cocktail.ingredients.contains { $0.name == "gin" }
            }
        case .vodka:
            return #Predicate<Cocktail> { cocktail in
                cocktail.isPossible &&
                cocktail.ingredients.contains { $0.name == "vodka" }
            }
        case .vermouth:
            return #Predicate<Cocktail> { cocktail in
                cocktail.isPossible &&
                cocktail.ingredients.contains { $0.name == "vermouth" }
            }
        case .whisky:
            return #Predicate<Cocktail> { cocktail in
                cocktail.isPossible &&
                cocktail.ingredients.contains {
                    return $0.name == "whisky" || $0.name == "rye whiskey"
                }
            }
        case .shortDrink:
            return #Predicate<Cocktail> { $0.isPossible && $0.styleValue == "short drink" }
        case .longDrink:
            return #Predicate<Cocktail> { $0.isPossible && $0.styleValue == "long drink" }
        }
    }
}

/// Pickers for cocktail creation
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
}
