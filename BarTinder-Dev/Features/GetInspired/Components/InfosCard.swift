/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI component that handles Apple Intelligence placeholder and results.
*/

import SwiftUI

extension GeneratedCocktail {
    struct InfosCard: View {
        @Environment(GenerableModel.self) private var model
        @State private var value = false
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                if let cocktailStyle = model.cocktailIdea?.content.style,
                   let cocktailGlass = model.cocktailIdea?.content.glass,
                   let cocktailDifficulty = model.cocktailIdea?.content.difficulty {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(cocktailGlass)
                                .resizable()
                                .frame(width: BarTinderApp.Size.image, height: BarTinderApp.Size.image)
                            Text("\(cocktailStyle.capitalized) \(cocktailStyle.capitalized)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Text(cocktailDifficulty.capitalized)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                    .padding(.horizontal)
                } else if model.cocktailIdea != nil {
                    PlaceHolderGenerable(
                        image: "circle.dotted.circle.fill", 
                        titleOne: "Designing", 
                        titleTwo: "the options",
                    )
                    .transition(.opacity.combined(with: .scale))
                }
                
                if let ingredients = model.cocktailIdea?.content.ingredients {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(ingredients) { ingredient in
                            IngredientRowGenerable(ingredient: ingredient)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.gray.opacity(0.05), in: RoundedRectangle(cornerRadius: 8))
                                .padding(.horizontal)
                        }
                    }
                } else if model.cocktailIdea?.content != nil {
                    PlaceHolderGenerable(
                        image: "flask.fill", 
                        titleOne: "Mixing", 
                        titleTwo: "your ingredients",
                    )
                    .transition(.opacity.combined(with: .scale))
                }
            }
            .onAppear {
                value = true
            }
            .animation(.easeInOut(duration: 0.3), value: model.cocktailIdea?.content.ingredients != nil)
            .animation(.easeInOut(duration: 0.3), value: model.cocktailIdea?.content.style != nil)
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    GeneratedCocktail.InfosCard()
}



extension GeneratedCocktail.InfosCard {
    /// Each row for the generated ingredients.
    struct IngredientRowGenerable: View {
        let ingredient: IngredientIdea.PartiallyGenerated?
        
        var body: some View {
            HStack(alignment: .center, spacing: 12) {
                if let ingredientLogo = ingredient?.name?.logolized() {
                    Image(ingredientLogo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: BarTinderApp.Size.image, height: BarTinderApp.Size.image)
                        .clipShape(Circle())
                        .background(Circle().fill(.gray.opacity(0.1)))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    if let ingredientName = ingredient?.name {
                        Text(ingredientName.capitalizedWords)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    
                    HStack(spacing: 5) {
                        if let ingredientAmount = ingredient?.amount {
                            if let ingredientUnit = ingredient?.unit {
                                if ingredientUnit != "To Rinse" && ingredientUnit != "Top Up" {
                                    Text(String(ingredientAmount))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Text(ingredientUnit)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

extension GeneratedCocktail.InfosCard {
    /// The placeholder when it's not generated yet.
    struct PlaceHolderGenerable: View {
        let image: String
        let titleOne: String
        let titleTwo: String
        
        var body: some View {
            HStack {
                Image(systemName: image)
                HStack(spacing: 5) {
                    Text(titleOne)
                        .fontWeight(titleOne == "Designing" ? .semibold : .regular)
                    Text(titleTwo)
                        .fontWeight(titleOne != "Designing" ? .semibold : .regular)
                }
                .font(.system(size: 17))
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .previewCard()
            .padding()
        }
    }
}
