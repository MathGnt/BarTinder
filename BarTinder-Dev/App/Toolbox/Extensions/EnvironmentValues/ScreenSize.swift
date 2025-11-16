/*
See the LICENSE file for this project's licensing information.

Abstract:
An environment value extension to get full screen size. This is the recommended pattern after `UIScreen.main.bounds` was deprecated.
*/

import SwiftUI

extension EnvironmentValues {
    @Entry var screenWidth: CGFloat = 0
    @Entry var screenHeight: CGFloat = 0
}
