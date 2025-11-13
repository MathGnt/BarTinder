/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that shows a Tip to guide the user on the swipe gesture.
*/

import Foundation
import TipKit

struct SwipeTip: Tip {
    var title: Text {
        Text("Swipe!")
    }
    
    var message: Text? {
        Text("Swipe left to dislike, or right to like!")
    }
    var image: Image? {
        Image(systemName: "hand.draw")
    }
}
