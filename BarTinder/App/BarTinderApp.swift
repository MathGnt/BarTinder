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
            // Fallback to in-memory container
            do {
                let config = ModelConfiguration(isStoredInMemoryOnly: true)
                container = try ModelContainer(for: Cocktail.self, configurations: config)
                PatchBay.patch.setContext(container.mainContext)
            } catch {
                fatalError("Failed to create fallback in-memory container: \(error)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Switching()
                .modelContainer(container)
        }
    }
}
