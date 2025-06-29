//
//  CocktailList.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/06/2025.
//

import SwiftUI

struct CocktailList: View {
    @State private var selectedCocktail: Cocktail?
    let cocktails: [Cocktail]
    
    var body: some View {
        List(cocktails) { cocktail in
            HStack(spacing: 15) {
                cocktail.displayedImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(.circle)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(cocktail.name)
                        .fontWeight(.semibold)
                    Text(cocktail.flavor.capitalized)
                        .font(.callout)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(cocktail.glass.rawValue)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                selectedCocktail = cocktail
            }
        }
        .navigationDestination(item: $selectedCocktail) { cocktail in
            CocktailDetail(cocktail: cocktail)
        }
    }
}

#Preview {
    CocktailList(cocktails: Cocktail.mocksArray)
}
