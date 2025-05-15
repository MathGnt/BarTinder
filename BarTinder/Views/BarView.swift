//
//  BarView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import SwiftUI
import SwiftData

struct BarView: View {
    
    @Environment(\.modelContext) private var context
    @State private var selectedCocktail: Cocktail?
    @Query(filter: Cocktail.isInBarPredicate()) private var barCocktails: [Cocktail]
    
    var body: some View {
        
        List {
            ForEach(barCocktails) { cocktail in
                HStack(spacing: 15) {
                    cocktail.displayedImage?
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
           
            .onDelete { indexes in
                for index in indexes {
                    barCocktails[index].isInBar.toggle()
                    try? context.save()
                }
            }
        }
        .navigationTitle("Bar")
        .navigationDestination(item: $selectedCocktail) { selectedCocktail in
            CocktailDetailView(cocktail: selectedCocktail)
        }
    }
}

#Preview {
    BarView()
}
