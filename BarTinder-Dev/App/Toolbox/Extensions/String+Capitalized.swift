/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An extension to capitalize measures except cl.
*/

import Foundation
import SwiftData
import SwiftUI

extension String {
    var capitalizedWords: String {
        self.split(separator: " ").map { word in
            word.lowercased().hasPrefix("cl") ? String(word) : word.capitalized
        }.joined(separator: " ")
    }
}
