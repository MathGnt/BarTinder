/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An enum for the different focus states of BarTinder & the return button.
*/

import Foundation
import SwiftUI


nonisolated enum Focus {
    case name
    case description
    case word
}


struct KeyboardReturnButton: ToolbarContent {
    @FocusState.Binding var focus: Focus?
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .keyboard) {
            HStack {
                Spacer()
                Button("Return") {
                    focus = nil
                }
            }
            .contentShape(.rect)
        }
    }
}
