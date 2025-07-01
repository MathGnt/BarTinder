//
//  Switching.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/06/2025.
//

import SwiftUI

/// A view that act like a railroad switcher to show 'swipe' or 'home' based on if the user already selected the cards.
struct Switching: View {
    @Environment(\.modelContext) private var context /* SwiftData Main Setup */
    @State private var appStorage = Storage()

    var body: some View {
        ZStack {
            if !appStorage.hasFinshedSwiping {
                Swipe()
                    .transition(.opacity.combined(with: .scale))
            } else {
                Home()
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
                    .environment(\.swiftData, SwiftDataSource(context: context))
                 
            }
        }
        .animation(.easeInOut(duration: 0.6), value: appStorage.hasFinshedSwiping)
        .environment(appStorage)
    }
}

#Preview {
    Switching()
}
