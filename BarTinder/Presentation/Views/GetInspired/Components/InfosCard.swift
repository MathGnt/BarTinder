//
//  InfosCard.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/07/2025.
//

import SwiftUI

extension GetInspired {
    /// A view that shows all the details about the generated cocktail.
    struct InfosCard: View {
        @Environment(GenerableViewModel.self) private var viewModel
        @State private var value = false
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                if let cocktailStyle = viewModel.cocktailIdea?.style,
                   let cocktailTechnique = viewModel.cocktailIdea?.mixingTechnique,
                   let cocktailGlass = viewModel.cocktailIdea?.glass,
                   let cocktailDifficulty = viewModel.cocktailIdea?.difficulty {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(cocktailGlass)
                                .resizable()
                                .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                            Text("\(cocktailTechnique.capitalized) • \(cocktailStyle.capitalized)")
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
                } else if viewModel.cocktailIdea != nil {
                    PlaceHolderGenerable(
                        image: "circle.dotted.circle.fill", 
                        titleOne: "Designing", 
                        titleTwo: "the options",
                    )
                    .transition(.opacity.combined(with: .scale))
                }
                
                if let ingredients = viewModel.cocktailIdea?.ingredients {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(ingredients) { ingredient in
                            IngredientRowGenerable(ingredient: ingredient)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(.gray.opacity(0.05), in: RoundedRectangle(cornerRadius: 8))
                                .padding(.horizontal)
                        }
                    }
                } else if viewModel.cocktailIdea != nil {
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
            .animation(.easeInOut(duration: 0.3), value: viewModel.cocktailIdea?.ingredients != nil)
            .animation(.easeInOut(duration: 0.3), value: viewModel.cocktailIdea?.style != nil)
        }
    }
}

#Preview {
    GetInspired.InfosCard()
        .environment(PatchBay.patch.makeGenerableViewModel())
}


/// Each row for the generated ingredients.
private struct IngredientRowGenerable: View {
    let ingredient: IngredientIdea.PartiallyGenerated?
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            if let ingredientLogo = ingredient?.name?.logolized() {
                Image(ingredientLogo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
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


/// The placeholder when it's not generated yet.
private struct PlaceHolderGenerable: View {
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
