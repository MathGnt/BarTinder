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

// Swift Data setup

extension EnvironmentValues {
    @Entry var swiftData = SwiftDataSource()
}
