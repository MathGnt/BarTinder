//
//  InfosCard.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/07/2025.
//

import SwiftUI

struct InfosCard: View {
    let viewModel: GenerableViewModel
    
    
    private func difficultyLevel(_ difficulty: String) -> Int {
        switch difficulty.lowercased() {
        case "easy": return 1
        case "medium": return 2
        case "hard": return 3
        default: return 1
        }
    }
    
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
                            ForEach(1...3, id: \.self) { index in
                                Image(systemName: index <= difficultyLevel(cocktailDifficulty) ? "wineglass.fill" : "wineglass")
                                    .font(.system(size: 16))
                                    .foregroundStyle(index <= difficultyLevel(cocktailDifficulty) ? .primary : .secondary)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            if let ingredients = viewModel.cocktailIdea?.ingredients {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(ingredients) { ingredient in
                        IngredientRowGenerable(ingredient: ingredient)
                    }
                }
            }
        }
    }
}

#Preview {
    InfosCard(viewModel: GenerableViewModel())
}
