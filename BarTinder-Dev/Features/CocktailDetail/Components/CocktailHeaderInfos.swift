/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that displays summary information about a cocktail including difficulty, style, glass type, and technique.
*/

import SwiftUI

extension CocktailDetail {
    struct CocktailHeaderInfos: View {
        let cocktail: Cocktail
        
        var body: some View {
            HStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Difficulty")
                        .font(.system(size: 15, design: .serif))
                    HStack {
                        ForEach(1...3, id: \.self) { index in
                            Image(systemName: index <= cocktail.difficulty.level ? "wineglass.fill" : "wineglass")
                        }
                        .frame(height: 24)
                    }
                    .font(.system(size: 15))
                }
                
                separator
                cocktailDetail(title: "Style", image: cocktail.style.rawValue)
                separator
                cocktailDetail(title: "Glass", image: cocktail.glass.rawValue)
                separator
        
                VStack(spacing: 9) {
                    Text("Technique")
                        .font(.system(size: 15, design: .serif))
                    Text(cocktail.mixingTechniqueValue.capitalizedWords)
                        .font(.system(size: 16, design: .rounded))
                    
                }
                
            }
        }
        
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
        
        private var separator: some View {
            Rectangle()
                .frame(width: 1, height: 50)
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    CocktailDetail.CocktailHeaderInfos(cocktail: Cocktail.ginto)
}
