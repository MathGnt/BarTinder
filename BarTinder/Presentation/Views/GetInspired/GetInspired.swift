//
//  GetInspired.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/07/2025.
//

import SwiftUI

struct GetInspired: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focus: Focus?
    @Binding var currentDetent: PresentationDetent
    @State private var cocktail: Cocktail?
    @State private var viewModel = GenerableViewModel()
    
    var body: some View {
        Group {
            if viewModel.notGenerated {
                DescribeYourCocktail(viewModel: viewModel, currentDetent: $currentDetent)
            } else {
                ScrollView {
                  
                        VStack(alignment: .leading, spacing: 0) {
                            HeaderMesh()
                                .overlay(alignment: .bottom) {
                                    titleHeader(viewModel: viewModel)
                                        .padding(.bottom, 80)
                                        .padding(.horizontal, 24)
                                        .foregroundStyle(.white)
                                }
                            if viewModel.cocktailIdea != nil {
                            VStack(spacing: 20) {
                                InfosCard(viewModel: viewModel)
                                
                                if viewModel.showButtons {
                                    Button {
                                        self.cocktail = viewModel.createCocktail()
                                    } label: {
                                        Label("Make it yours", systemImage: "plus.circle.fill")
                                            .fontWeight(.semibold)
                                    }
                                    .buttonStyle(GenerateButton(color: .blue))
                                    
                                    Button {
                                        
                                    } label: {
                                        Label("I don't like it", systemImage: "xmark.diamond")
                                    }
                                    .buttonStyle(GenerateButton(color: .red))
                                }
                                   
                            }
                            .animation(.easeIn, value: viewModel.showButtons)
                            .padding(.vertical, 24)
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                            .padding(.horizontal)
                            .offset(y: -60)
                        }
                    }
                }
                .ignoresSafeArea()
                .background(
                    LinearGradient(
                        stops: [
                            .init(color: .purple.opacity(0.1), location: 0.0),
                            .init(color: .purple.opacity(0.05), location: 0.9),
                            .init(color: .clear, location: 1.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    cocktail = nil
                    viewModel.cocktailIdea = nil
                    viewModel.word = ""
                }
                .navigationDestination(item: $cocktail, destination: { Hashable in
                    CreateEditCocktail(cocktail: Hashable)
                })
            }
        }
    }
    
    private func titleHeader(viewModel: GenerableViewModel) -> some View {
        VStack(spacing: 15) {
            if let cocktailName = viewModel.cocktailIdea?.name {
                Text(cocktailName)
                    .font(.system(size: 35, weight: .semibold, design: .serif))
                    .minimumScaleFactor(0.7)
            } else {
                HStack {
                    Image(systemName: "sparkles")
                    Text("Crafting your idea...")
                }
                .font(.system(size: 35, weight: .semibold, design: .rounded))
                .minimumScaleFactor(0.7)
            }
            if let cocktailDescription = viewModel.cocktailIdea?.description {
                Text(cocktailDescription)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    GetInspired(currentDetent: .constant(.large))
        .environment(PatchBay.patch.makeCocktailViewModel())
}
