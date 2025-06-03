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
    let viewModel: CocktailViewModel
    
    @Query(filter: CocktailFilterCategory.byInBar()) private var cocktails: [Cocktail]
    
    var body: some View {
        
        if cocktails.isEmpty {
            VStack {
                Spacer()
                ContentUnavailableView(
                    "No cocktails in bar",
                    systemImage: "wineglass",
                    description: Text("Add cocktail to your bar by clicking on the wine bottle inside them!")
                )
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(cocktails) { cocktail in
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
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedCocktail = cocktail
                    }
                }
            }
            .navigationTitle("Bar")
            .navigationDestination(item: $selectedCocktail) { selectedCocktail in
                CocktailDetail(cocktail: selectedCocktail)
            }
        }
    }
}


#Preview {
    Bar(viewModel: PatchBay.patch.makeCocktailViewModel())
}
