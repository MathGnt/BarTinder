//
//  CocktailLogosDetails.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI

struct CocktailHeaderInfos: View {
    
    let cocktail: Cocktail
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 4) {
                Text("Difficulty")
                    .font(.system(size: 15, design: .serif))
                HStack {
                    ForEach(1...3, id: \.self) { index in
                        Image(systemName: index <= cocktail.difficulty ? "wineglass.fill" : "wineglass")
                    }
                    .frame(height: 24)
                }
                .font(.system(size: 15))
            }
            
            Rectangle()
                .frame(width: 1, height: 50)
            
            cocktailDetail(title: "Style", image: cocktail.style)
            
            Rectangle()
                .frame(width: 1, height: 50)
            
            cocktailDetail(title: "Glass", image: cocktail.glass)
            
        }
    }
}


private extension CocktailHeaderInfos {
    
    private func cocktailDetail(title: String, image: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 15, design: .serif))
            
            Image(image)
                .resizable()
                .renderingMode(.template)
                .frame(width: 25, height: 25)
            
        }
    }
}
