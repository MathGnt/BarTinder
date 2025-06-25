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
                .onAppear {
                    print("rawvalue is \(cocktail.glass.rawValue)")
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
        CocktailDetail(cocktail: Cocktail.mocks)
    }
}

//MARK: - View Functions & Structs

private extension CocktailDetail {
    
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
    
    private struct CocktailHeaderPicture: View {
        
        @Environment(\.colorScheme) private var scheme
        let cocktail: Cocktail
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                cocktail.displayedImage
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                cocktail.displayedImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .blur(radius: 16, opaque: true)
                    .saturation(1.3)
                    .brightness(0.15)
                    .mask {
                        Rectangle()
                            .fill(
                                Gradient(stops: [
                                    .init(color: .clear, location: 0.5),
                                    .init(color: .white, location: 0.65)
                                ])
                                .colorSpace(.perceptual)
                            )
                    }
            }
            .frame(height: 400)
            .frame(maxWidth: .infinity)
            .compositingGroup()
            .mask {
                Rectangle()
                    .fill(
                        Gradient(stops: [
                            .init(color: .white, location: 0.3),
                            .init(color: .clear, location: 1.0)
                        ])
                        .colorSpace(.perceptual)
                    )
            }
            .ignoresSafeArea()
        }
    }
    
    
    private struct IngredientsList: View {
        let cocktail: Cocktail
        
        var body: some View {
            VStack(alignment: .center, spacing: 4) {
                Text("Ingredients")
                    .font(.system(size: 17, design: .serif))
                Spacer(minLength: 15)
                ForEach(cocktail.ingredients) { ingredient in
                    HStack {
                        Image(ingredient.name.logolized())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Text(ingredient.name.capitalizedWords)
                        Spacer()
                        Text("\(ingredient.measure) \(ingredient.unit.rawValue)")
                    }
                }
            }
        }
    }
    
    private struct DetailToolbar: ToolbarContent {
        @Environment(\.dismiss) private var dismiss
        let cocktail: Cocktail
        
        var body: some ToolbarContent {
            ToolbarItem {
                Menu {
                    Section {
                        ControlGroup {
                            NavigationLink {
                                CreateEditCocktail(cocktail: cocktail)
                            } label: {
                                Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                            }
                            .disabled(cocktail.stock)
                            
                            Button {
                                cocktail.isPossible = false
                                dismiss()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    
                    Section {
                        Button {
                            cocktail.isInBar.toggle()
                        } label: {
                            Label(cocktail.isInBar ? "Remove from bar" : "Add in bar", systemImage: cocktail.isInBar ? "wineglass.fill" : "wineglass")
                                .foregroundStyle(cocktail.isInBar ? .primary : Color(.green))
                        }
                    }
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
}


