//
//  CocktailDetail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import SwiftUI
import SwiftData

struct CocktailDetail: View {
    
    @Environment(\.colorScheme) private var scheme
    let cocktail: Cocktail
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    topImage(cocktail: cocktail, scheme: scheme)
                    
                    VStack(spacing: 25) {
                        header(cocktail)
                        CocktailHeaderInfos(cocktail: cocktail)
                        
                        HStack {
                            ingredientsList(cocktail)
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Spacer()
                        }
                        .padding(.top, 15)
                        .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.top, -65) /* <---- c'est horrible mais je trouve pas de soluce */
                }
            }
            .toolbarRole(.editor)
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    cocktail.isInBar.toggle()
                } label: {
                    Circle()
                        .shadow(radius: 2)
                        .background(.thinMaterial)
                        .frame(height: 32)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .foregroundStyle(.clear)
                        .overlay {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 15)
                                .foregroundStyle(.turborider)
                                .fontWeight(.bold)
                        }
                }
               
            }
            
        }
        .toolbarBackground(.thinMaterial, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        CocktailDetail(cocktail: Cocktail.mocks)
    }
}

//MARK: - View Functions

private extension CocktailDetail {
    
    private func topImage(cocktail: Cocktail, scheme: ColorScheme) -> some View {
        cocktail.displayedImage
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 400)
            .frame(maxWidth: .infinity)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: scheme == .light ? [Color.white.opacity(1.7), Color.white.opacity(0)] : [Color.black.opacity(1.7), Color.black.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 150)
                .alignmentGuide(.top) { _ in 0 }
                    .padding(.top, 250)
            )
            .clipped()
            .ignoresSafeArea()
    }
    
    private func header(_ cocktail: Cocktail) -> some View {
        VStack(spacing: 10) {
            Text(cocktail.name)
                .font(.system(size: 35, weight: .regular, design: .serif))
            Text(cocktail.cocktailDescription)
                .font(.system(size: 14, design: .rounded))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
        }
    }
    
    @MainActor
    private func ingredientsList(_ cocktail: Cocktail) -> some View {
        VStack(alignment: .center, spacing: 4) {
            Text("Ingredients")
                .font(.system(size: 17, design: .serif))
            
            ForEach(cocktail.ingredientsMeasures) { ingredientMeasure in
                HStack {
                    Image(ingredientMeasure.ingredient.logolized())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text(ingredientMeasure.ingredient.capitalizedWords)
                    Spacer()
                    Text(ingredientMeasure.measure.capitalizedWords)
                }
            }
        }
    }
}


