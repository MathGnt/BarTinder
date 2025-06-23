//
//  CocktailOptions.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/06/2025.
//

import Foundation

// Filtering and Sorting @Query

enum CocktailSortDescriptor: String, CaseIterable {
    case name = "Name"
    case difficulty = "Difficulty"
    case glass = "Glass"
    case technique = "Technique"
    case abv = "ABV"
    
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
        case .abv:
            [SortDescriptor(\Cocktail.abv, order: order),
             SortDescriptor(\Cocktail.name, order: .forward)]
        }
    }
}

enum CocktailFilterPredicate: String, CaseIterable {
    case possibleCocktails = "Your cocktails"
    case gin = "Gin"
    case vodka = "Vodka"
    case vermouth = "Vermouth"
    case whisky = "Whisky"
    case shortDrink = "Short Drinks"
    case longDrink = "Long Drinks"
    
    // Static filtering
    static func byIngredient(_ ingredient: Ingredient) -> Predicate<Cocktail> {
        let name = ingredient.name
        return #Predicate<Cocktail> {
            $0.ingredientsMeasures.contains { $0.ingredient == name }
        }
    }
    
    static var byInBar: Predicate<Cocktail> {
        #Predicate<Cocktail> {
            $0.isInBar == true
        }
    }
    
    // Dynamic filtering
    var filterPredicate: Predicate<Cocktail> {
        
        switch self {
        case .possibleCocktails:
            return #Predicate<Cocktail> { $0.isPossible == true }
        case .gin:
            return #Predicate<Cocktail> { cocktail in
                cocktail.isPossible == true &&
                cocktail.ingredientsMeasures.contains { $0.ingredient == "gin" }
            }
        case .vodka:
            return #Predicate<Cocktail> { cocktail in
                cocktail.isPossible == true &&
                cocktail.ingredientsMeasures.contains { $0.ingredient == "vodka" }
            }
        case .vermouth:
            return #Predicate<Cocktail> { cocktail in
                cocktail.isPossible == true &&
                cocktail.ingredientsMeasures.contains { $0.ingredient == "vermouth" }
            }
        case .whisky:
            return #Predicate<Cocktail> { cocktail in
                cocktail.isPossible == true &&
                cocktail.ingredientsMeasures.contains {
                    return $0.ingredient == "whisky" || $0.ingredient == "rye whiskey"
                }
            }
        case .shortDrink:
            return #Predicate<Cocktail> { $0.isPossible == true && $0.style.rawValue == "shortdrink" }
        case .longDrink:
            return #Predicate<Cocktail> { $0.isPossible == true && $0.style.rawValue == "longdrink" }
        }
    }
}

// Pickers for cocktail creation

enum CocktailStyle: String, Identifiable, CaseIterable, Codable {
    case longDrink = "longdrink"
    case shortDrink = "shortdrink"
    
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

enum CocktailDifficulty: Int, Codable {
    case easy = 1
    case medium = 2
    case hard = 3
}

enum Units: String, CaseIterable, Identifiable {
    case cl = "cl"
    case dash = "Dash"
    case drop = "Drop"
    case pinch = "Pinch"
    case wedge = "Wedge"
    case topUp = "Top Up"
    case toRinse = "To Rinse"
    
    var id: String { self.rawValue }
}
