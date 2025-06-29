//
//  Switching.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/06/2025.
//

import SwiftUI

struct Switching: View {
    @Environment(\.modelContext) private var context // SwiftData Setup
    @AppStorage("fetched-cocktails") private var hasFetchedCocktails = false
    @AppStorage("finish-swiping") private var finishSwiping: Bool = false

    var body: some View {
        ZStack {
            if !finishSwiping {
                Swipe(hasFetchedCocktails: $hasFetchedCocktails, finishSwiping: $finishSwiping)
                    .transition(.opacity.combined(with: .scale))
            } else {
                Home(finishSwiping: $finishSwiping, hasFetched: $hasFetchedCocktails)
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
                    .environment(\.swiftData, SwiftDataSource(context: context))
            }
        }
        .animation(.easeInOut(duration: 0.6), value: finishSwiping)
    }
    
}

#Preview {
    Switching()
}
