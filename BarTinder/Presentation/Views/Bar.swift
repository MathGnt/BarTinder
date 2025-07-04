//
//  Bar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import SwiftUI
import SwiftData

/// A view that shows all cocktail the user added to his bar.
struct Bar: View {
    @State private var selectedCocktail: Cocktail?
    @Query(filter: CocktailFilterPredicate.byInBar) private var cocktails: [Cocktail]
    
    var body: some View {
        
        if cocktails.isEmpty {
            ContentUnavailableView(
                "No cocktails in bar",
                systemImage: "wineglass",
                description: Text("You can add cocktails to your bar by tapping \(Image(systemName: "ellipsis.circle")) inside a cocktail and choosing Add to Bar.")
            )
        } else {
            CocktailList(cocktails: cocktails)
                .navigationTitle("Bar")
        }
    }
}


#Preview(traits: .queryMocks) {
    Bar()
}
