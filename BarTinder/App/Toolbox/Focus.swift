//
//  Focus.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 26/06/2025.
//

import Foundation
import SwiftUI


nonisolated enum Focus {
    case name
    case description
    case measure
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
