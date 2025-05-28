//
//  CocktailDetailView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import SwiftUI
import SwiftData

struct CocktailDetailView: View {
    
    @Environment(\.colorScheme) private var scheme
    @Environment(\.modelContext) private var context
    let cocktail: Cocktail
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .bottom) {
                    topImage(cocktail: cocktail, scheme: scheme)
                    VStack(spacing: 20) {
                        header(cocktail)
                        CocktailLogosDetailsCpn(cocktail: cocktail)
                    }
                }
                
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
            
            HStack {
                Spacer()
                VStack {
                    Button {
                        isInBar(cocktail: cocktail, context: context)
                    } label: {
                        Image(systemName: cocktail.isInBar ? "wineglass.fill" : "wineglass")
                            .resizable()
                            .foregroundStyle(.turborider)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .toolbarRole(.editor)
    }
    
    private func isInBar(cocktail: Cocktail, context: ModelContext) {
        cocktail.isInBar.toggle()
        try? context.save()
    }
}

#Preview {
    CocktailDetailView(cocktail: Cocktail.mocks)
}

//MARK: - View Functions

extension CocktailDetailView {
    
    private func topImage(cocktail: Cocktail, scheme: ColorScheme) -> some View {
        cocktail.displayedImage?
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


