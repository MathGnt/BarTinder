/*
See the LICENSE file for this project's licensing information.

Abstract:
A Binding extension to display alerts based on the presenting item.
*/

import Foundation
import SwiftUI

extension Binding where Value: Equatable {
    static func isPresent<T>(_ source: Binding<T?>) -> Binding<Bool> where Value == Bool {
        Binding<Bool>(
            get: { source.wrappedValue != nil },
            set: { newValue in
                if !newValue {
                    source.wrappedValue = nil
                }
            }
        )
    }
}
