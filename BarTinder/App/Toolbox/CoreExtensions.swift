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
