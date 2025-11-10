/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A design system storing the core spacing and sizing values used throughout the app.
*/

import Foundation
import SwiftUI

extension BarTinderApp {
    enum Padding {
        static let ingredientSpacing: CGFloat = 15
        static let scrollViewSpacing: CGFloat = 10
        static let titleSpacingTop: CGFloat = 15
        static let titleSpacingBottom: CGFloat = 5
        static let bigTitleSpacingTop: CGFloat = 30
        static let bigTitleSpacingBottom: CGFloat = 20
        static let scrollViewVerticalSpacing: CGFloat = 5
    }

    enum CornerRadius {
        static let small: CGFloat = 8
        static let main: CGFloat = 20
    }

    enum Size {
        static let cardWidth: CGFloat = 180
        static let cardHeight: CGFloat = 260
        static let image: CGFloat = 40
    }
    
    enum SwipingSettings {
        static let swipeOutDistance: CGFloat = 500
        static let maxRotation: Double = 12
        static let gradientHeightOffset: CGFloat = 200
    }
}
