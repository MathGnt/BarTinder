//
//  CocktailDetail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import SwiftUI
import SwiftData

struct CocktailDetail: View {
    let cocktail: Cocktail
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    CocktailHeaderPicture(cocktail: cocktail)
                        .overlay(alignment: .bottom) {
                            header(cocktail)
                                .offset(y: -30)
                        }
                    
                    VStack(spacing: 25) {
                        CocktailHeaderInfos(cocktail: cocktail)
                        HStack {
                            IngredientsList(cocktail: cocktail)
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Spacer()
                        }
                        .padding(.top, 15)
                        .padding(.horizontal)
                        Spacer()
                    }
                }
            }
            .toolbarRole(.editor)
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            DetailToolbar(cocktail: cocktail)
        }
    }
}

#Preview {
    NavigationStack {
        CocktailDetail(cocktail: Cocktail.ginto)
    }
}

//MARK: - Small components

private extension CocktailDetail {
    
    private func header(_ cocktail: Cocktail) -> some View {
        VStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
            Text(cocktail.name)
                .font(.system(size: 35, weight: .regular, design: .serif))
            Text(cocktail.cocktailDescription)
                .font(.system(size: 14, design: .rounded))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
        }
    }
}


