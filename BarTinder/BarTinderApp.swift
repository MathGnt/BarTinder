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
    
    let cocktailRepo = CocktailRepo(networkManager: NetworkManager())
    
    var body: some Scene {
        WindowGroup {
            SwipeView(repo: cocktailRepo)
        }
        .modelContainer(for: Cocktail.self)
    }
}
