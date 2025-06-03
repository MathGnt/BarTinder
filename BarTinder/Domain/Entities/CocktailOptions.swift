//
//  CocktailOptions.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/06/2025.
//

import Foundation

// Filtering and Sorting @Query

enum CocktailSortOption: String, CaseIterable {
    case name = "Name"
    case difficulty = "Difficulty"
    case glass = "Glass"
    case preparation = "Preparation"
    case abv = "ABV"
    
    var sortDescriptors: [SortDescriptor<Cocktail>] {
        switch self {
        case .name:
            [SortDescriptor(\Cocktail.name)]
        case .difficulty:
            [SortDescriptor(\Cocktail.difficulty)]
        case .glass:
            [SortDescriptor(\Cocktail.glass)]
        case .preparation:
            [SortDescriptor(\Cocktail.preparation)]
        case .abv:
            [SortDescriptor(\Cocktail.abv)]
        }
    }
}

enum CocktailFilterCategory: String, CaseIterable {
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
    
    static func byInBar() -> Predicate<Cocktail> {
        return #Predicate<Cocktail> {
            $0.isInBar == true
        }
    }
    
    // Dynamic filtering
    var filterCategory: Predicate<Cocktail> {
         let predicate: Predicate<Cocktail>
         
         switch self {
         case .possibleCocktails:
             predicate = #Predicate<Cocktail> { $0.isPossible == true }
         case .gin:
             predicate = #Predicate<Cocktail> { cocktail in
                 cocktail.isPossible == true &&
                 cocktail.ingredientsMeasures.contains { $0.ingredient == "gin" }
             }
         case .vodka:
             predicate = #Predicate<Cocktail> { cocktail in
                 cocktail.isPossible == true &&
                 cocktail.ingredientsMeasures.contains { $0.ingredient == "vodka" }
             }
         case .vermouth:
             predicate = #Predicate<Cocktail> { cocktail in
                 cocktail.isPossible == true &&
                 cocktail.ingredientsMeasures.contains { $0.ingredient == "vermouth" }
             }
         case .whisky:
             predicate = #Predicate<Cocktail> { cocktail in
                 cocktail.isPossible == true &&
                 cocktail.ingredientsMeasures.contains {
                     return $0.ingredient == "whisky" || $0.ingredient == "rye whiskey"
                 }
             }
         case .shortDrink:
             predicate = #Predicate<Cocktail> { $0.isPossible == true && $0.style == "shortdrink" }
         case .longDrink:
             predicate = #Predicate<Cocktail> { $0.isPossible == true && $0.style == "longdrink" }
         }
         
         return predicate
     }
}

// Pickers for cocktail creation

enum CocktailStyle: String, Identifiable, CaseIterable {
    case longDrink = "longdrink"
    case shortDrink = "shortdrink"
    
    var id: String { self.rawValue }
}

enum CocktailGlass: String, Identifiable, CaseIterable {
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

enum CocktailPreparation: String, Identifiable, CaseIterable {
    case built = "built"
    case stirred = "stirred"
    case shaken = "shaken"
    case blended = "blended"
    case thrown = "thrown"
    case layered = "layered"
    
    var id: String { self.rawValue }
}

enum CocktailDifficulty: Int {
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

