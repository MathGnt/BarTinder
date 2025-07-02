//
//  GetInspired.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/07/2025.
//

import SwiftUI

struct GetInspired: View {
    @State private var cocktail: Cocktail?
    @State private var viewModel = GenerableViewModel()
    @FocusState private var focus: Focus?
    @State private var isPresented = true
    @Environment(CocktailViewModel.self) private var cocktailVM
    var body: some View {
        VStack {
            if let cocktailName = viewModel.cocktailIdea?.name {
                Text(cocktailName)
            }
            if let cocktailDescription = viewModel.cocktailIdea?.description {
                Text(cocktailDescription)
            }
            
            if let ingredients = viewModel.cocktailIdea?.ingredients {
          
                    ForEach(ingredients) { ingredient in
                        HStack {
                            if let ingredientLogo = ingredient.name?.logolized() {
                                Image(ingredientLogo)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                            }
                            if let ingredientName = ingredient.name {
                                Text(ingredientName)
                            }
                            if let ingredientAmount = ingredient.amount {
                                Text(String(ingredientAmount))
                            }
                            if let ingredientUnit = ingredient.unit {
                                Text(ingredientUnit)
                            }
                        }
                    }
                
            }
            if let cocktailStyle = viewModel.cocktailIdea?.style {
                Text(cocktailStyle)
            }
            if let cocktailGlass = viewModel.cocktailIdea?.glass {
                Text(cocktailGlass)
            }
            if let cocktailTechnique = viewModel.cocktailIdea?.mixingTechnique {
                Text(cocktailTechnique)
            }
            if let cocktailDifficulty = viewModel.cocktailIdea?.difficulty {
                Text(cocktailDifficulty)
            }
            Button("Create cocktail") {
                self.cocktail = viewModel.createCocktail()
            }
        }
        .navigationDestination(item: $cocktail, destination: { Hashable in
            CreateEditCocktail(cocktail: Hashable)
        })
        .sheet(isPresented: $isPresented) {
            VStack {
                TextField("A word to represent your cocktail", text: $viewModel.mood)
                    .focused($focus, equals: .word)
                    .onChange(of: focus) { _, newValue in
                        if newValue == .word {
                            viewModel.prewarm()
                        }
                    }
                Button("Generate") {
                    Task {
                        isPresented = false
                        await viewModel.generate()
                    }
                }
            }
            .presentationDetents([.height(150)])
        }
    }
}

#Preview {
    GetInspired()
}
