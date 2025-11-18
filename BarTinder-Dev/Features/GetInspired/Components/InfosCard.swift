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
                            Text(cocktailStyle.capitalized)
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
                                .background(.ingredientCapsule, in: .capsule)
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

#Preview(traits: .modelsEnvironment) {
    GeneratedCocktail.InfosCard()
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
