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
             PatchBay.patch.setContext(ModelContext(container))
         } catch {
             do {
                 container = try ModelContainer(
                     for: Cocktail.self,
                     configurations: ModelConfiguration(isStoredInMemoryOnly: true)
                 )
                 PatchBay.patch.setContext(ModelContext(container))
                 print("Using in-memory container as fallback")
             } catch {
                 fatalError("Failed to create even in-memory container: \(error)")
             }
         }
     }
    
    var body: some Scene {
        WindowGroup {
            SwipeView()
        }
        .modelContainer(container)
    }
}
