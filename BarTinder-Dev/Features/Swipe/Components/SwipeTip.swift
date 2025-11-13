//
//  SwipeTip.swift
//  BarTinder-Dev
//
//  Created by Mathis Gaignet on 13/11/2025.
//

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
