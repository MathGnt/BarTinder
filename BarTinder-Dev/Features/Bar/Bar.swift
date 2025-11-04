/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view that displays all cocktails the user added to their bar.
*/

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
