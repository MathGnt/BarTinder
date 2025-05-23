//
//  Extensions.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 05/05/2025.
//

import Foundation
import SwiftData
import SwiftUI

extension String {
    var capitalizedWords: String {
        self.split(separator: " ").map { word in
            word.lowercased().hasPrefix("cl") ? String(word) : word.capitalized
        }.joined(separator: " ")
    }
    
    func logolized() -> String {
        replacingOccurrences(of: " ", with: "") + "logo"
    }
}


extension Cocktail {
    static func isInBarPredicate() -> Predicate<Cocktail> {
        return #Predicate<Cocktail> {
            $0.isInBar == true
        }
    }
    
    static func isPossiblePredicate() -> Predicate<Cocktail> {
        return #Predicate<Cocktail> {
            $0.isPossible == true
        }
    }
    
    static func cocktailAboutIngredient(ingredient: Ingredient) -> Predicate<Cocktail> {
        let name = ingredient.name
        return #Predicate<Cocktail> {
            $0.ingredientsMeasures.contains { $0.ingredient == name }
        }
    }
}

extension View {
    func characterLimit(_ limit: Int, text: Binding<String>) -> some View {
        self
            .onChange(of: text.wrappedValue) { oldValue, newValue in
                if newValue.count > limit {
                    text.wrappedValue = String(newValue.prefix(limit))
                }
            }
    }
}

extension ModelContext {
    func deleteAll<T: PersistentModel>(_ model: T.Type) throws {
        let descriptor = FetchDescriptor<T>()
        let results = try self.fetch(descriptor)
        results.forEach { self.delete($0) }
        try self.save()
    }
}
