//
//  String+Logolized.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 11/07/2025.
//

import Foundation

extension String {
    /// To make image easily
    func logolized() -> String {
        replacingOccurrences(of: " ", with: "") + "logo"
    }
}
