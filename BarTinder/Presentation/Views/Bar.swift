//
//  Bar.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import SwiftUI
import SwiftData

struct Bar: View {
    
    @State private var selectedCocktail: Cocktail?
    
    @Query(filter: CocktailFilterPredicate.byInBar) private var cocktails: [Cocktail]
    
    var body: some View {
        
        if cocktails.isEmpty {
                ContentUnavailableView(
                    "No cocktails in bar",
                    systemImage: "wineglass",
                    description: Text("Add cocktails to your bar by navigating through their details!")
                )
        } else {
            CocktailList(cocktails: cocktails)
                .navigationTitle("Bar")
        }
    }
}


#Preview {
    Bar()
}
