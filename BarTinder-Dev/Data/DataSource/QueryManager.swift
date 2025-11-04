/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The filtering, sorting and ordering options available through predicates and descriptors.
*/

import Foundation

//MARK: - SORT DESCRIPTOR

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

//MARK: - PREDICATES

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
            return #Predicate<Cocktail> { $0.isPossible && $0.stock == false }
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
