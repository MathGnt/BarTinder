/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view that displays a list of cocktails.
*/

import SwiftUI

struct CocktailList: View {
    let cocktails: [Cocktail]
    
    var body: some View {
        List(cocktails) { cocktail in
            NavigationLink(value: RouterDestination.cocktailDetail(cocktail, nil)) {
                HStack(spacing: 15) {
                    cocktail.displayedImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(.circle)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(cocktail.name)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(cocktail.glass.rawValue)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                }
            }
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    NavigationStack {
        CocktailList(cocktails: Cocktail.mocksArray)
    }
}
