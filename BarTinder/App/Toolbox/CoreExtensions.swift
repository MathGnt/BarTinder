//
//  Extensions.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 05/05/2025.
//

import Foundation
import SwiftData
import SwiftUI

/// Extension for bindings - no need to deal with 'transaction' bug
extension Dictionary where Key == String, Value == String {
    subscript(ingredientMeasure id: String) -> String {
        get { self[id] ?? "" }
        set { self[id] = newValue }
    }
}

extension Dictionary where Key == String, Value == Units {
    subscript(ingredientUnit id: String) -> Units {
        get { self[id] ?? .cl }
        set { self[id] = newValue }
    }
}

extension String {
    var capitalizedWords: String {
        self.split(separator: " ").map { word in
            word.lowercased().hasPrefix("cl") ? String(word) : word.capitalized
        }.joined(separator: " ")
    }
    
    // To make image easily
    func logolized() -> String {
        replacingOccurrences(of: " ", with: "") + "logo"
    }
}

// TextField character limit

struct CharacterLimitModifier: ViewModifier {
    let limit: Int
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { oldValue, newValue in
                if newValue.count > limit {
                    text = String(newValue.prefix(limit))
                }
            }
    }
}

extension View {
    func characterLimit(_ limit: Int, text: Binding<String>) -> some View {
        modifier(CharacterLimitModifier(limit: limit, text: text))
    }
}

// Swift Data setup

extension EnvironmentValues {
    @Entry var swiftData = SwiftDataSource()
}
