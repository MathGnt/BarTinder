//
//  Header.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/06/2025.
//

import SwiftUI

extension CocktailDetail {
    
    struct CocktailHeaderPicture: View {
        
        @Environment(\.colorScheme) private var scheme
        let cocktail: Cocktail
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                cocktail.displayedImage
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                cocktail.displayedImage
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .blur(radius: 16, opaque: true)
                    .saturation(1.3)
                    .brightness(0.15)
                    .mask {
                        Rectangle()
                            .fill(
                                Gradient(stops: [
                                    .init(color: .clear, location: 0.5),
                                    .init(color: .white, location: 0.65)
                                ])
                                .colorSpace(.perceptual)
                            )
                    }
            }
            .frame(height: 400)
            .frame(maxWidth: .infinity)
            .compositingGroup()
            .mask {
                Rectangle()
                    .fill(
                        Gradient(stops: [
                            .init(color: .white, location: 0.3),
                            .init(color: .clear, location: 1.0)
                        ])
                        .colorSpace(.perceptual)
                    )
            }
            .ignoresSafeArea()
        }
    }
    
}
