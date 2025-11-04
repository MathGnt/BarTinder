/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A custom function to easily display the ingredient picture.
*/

import Foundation

extension String {
    func logolized() -> String {
        replacingOccurrences(of: " ", with: "") + "logo"
    }
}
