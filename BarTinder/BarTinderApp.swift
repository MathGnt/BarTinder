//
//  BarTinderApp.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 16/04/2025.
//

import SwiftUI
import SwiftData

@main
struct BarTinderApp: App {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Cocktail.self)
            PatchBay.patch.setContext(container.mainContext)
        } catch {
            fatalError("Failed to Create Context")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SwipeView()
                .modelContainer(container)
        }
    }
}
