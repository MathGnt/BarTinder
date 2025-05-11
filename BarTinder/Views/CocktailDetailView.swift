//
//  CocktailDetailView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/04/2025.
//

import SwiftUI
import SwiftData

struct CocktailDetailView: View {
    
    @Environment(\.modelContext) private var context
    let cocktail: Cocktail
    var body: some View {
        ZStack {
            
            VStack {
                ZStack(alignment: .bottom) {
                    
                    topImage(cocktail: cocktail)
                    
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
                
                HStack {
                    VStack(alignment: .center, spacing: 5) {
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
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                }
                
                .padding(.top, 20)
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
                            .foregroundStyle(.limegreen)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                           
                        
                    }
                    Spacer()
                }
           
            }
            .padding(.horizontal)
        }
        
    }
    
}

private func isInBar(cocktail: Cocktail, context: ModelContext) {
    cocktail.isInBar.toggle()
    try? context.save()
}

private func topImage(cocktail: Cocktail) -> some View {
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


#Preview {
    CocktailDetailView(cocktail: Cocktail(name: "Gin Tonic", ingredientsMeasures: [IngredientMeasure(ingredient: "gin", measure: "12 cl"), IngredientMeasure(ingredient: "tonic water", measure: "6 cl")], isInBar: true, isPossible: true, image: "gintonic", style: "longdrink", glass: "balloon", preparation: "Built", abv: "12", flavor: "Bitter", difficulty: 2, cocktailDescription: ""))
}
