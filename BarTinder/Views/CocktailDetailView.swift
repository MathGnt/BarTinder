//
//  CocktailDetailView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import SwiftUI

struct CocktailDetailView: View {
    
    let cocktail: Cocktail
    @Bindable var viewModel: SwipeViewModel
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image(cocktail.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 400)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white.opacity(1.7), Color.white.opacity(0)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .frame(height: 150)
                        .alignmentGuide(.top) { _ in 0 }
                            .padding(.top, 250)
                    )
                    .clipped()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Text(cocktail.name)
                            .font(.system(size: 35, weight: .regular, design: .serif))
                        Text(cocktail.cocktailDescription)
                            .font(.system(size: 14, design: .rounded))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    }

                    HStack(spacing: 20) {
                        VStack(spacing: 5) {
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
                        
                        VStack(spacing: 4) {
                            Text("Style")
                                .font(.system(size: 15, design: .serif))
    
                            Image(cocktail.style)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 25, height: 25)
            
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 50)
                        
                        VStack(spacing: 4) {
                            Text("Glass")
                                .font(.system(size: 15, design: .serif))
                            Image(cocktail.glass)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 25, height: 25)
                        }
                
                    }
               
                }
            }
 
            HStack {
                let ingredientsMeasures: [(String, String)] = viewModel.getIngredientsMeasures(cocktail: cocktail)
                VStack(alignment: .center, spacing: 7) {
                    Text("Ingredients")
                        .font(.system(size: 17, design: .serif))

                    ForEach(ingredientsMeasures, id: \.0) { ingredientMeasure in
                        HStack {
                            Image(ingredientMeasure.0.logolized())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text(ingredientMeasure.0.capitalizedWords)
                            Spacer()
                            Text(ingredientMeasure.1.capitalizedWords)
                        }
                    }

                        
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }
            .padding(.top, 30)
            .padding(.horizontal)
            Spacer()
            
        }
    }
}

#Preview {
    CocktailDetailView(cocktail: Cocktail.getMock(), viewModel: SwipeViewModel(repo: CocktailRepo(networkManager: NetworkManager())))
}
