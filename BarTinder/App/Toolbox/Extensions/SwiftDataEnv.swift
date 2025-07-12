//
//  SwiftDataEnv.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 11/07/2025.
//

import Foundation
import SwiftUI

/// Swift Data setup - Use @Environment(\.swiftData)
extension EnvironmentValues {
    @Entry var swiftData = SwiftDataSource()
}
