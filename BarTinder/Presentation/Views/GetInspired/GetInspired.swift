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
    @State private var cocktail: Cocktail?
    @State private var viewModel = GenerableViewModel()
    
    var body: some View {
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
                                dismiss()
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
        .task {
            await viewModel.generate()
        }
        .onAppear {
            cocktail = nil
            viewModel.cocktailIdea = nil
        }
        .navigationDestination(item: $cocktail, destination: { cocktail in
            CreateEditCocktail(cocktail: cocktail)
        })
        .alert("Not available", isPresented: $viewModel.notAvailable) {
            Button("Ok", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Apple intelligence is not available for your device")
        }
    }
    
    private func titleHeader(viewModel: GenerableViewModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if let cocktailName = viewModel.cocktailIdea?.name {
                Text(cocktailName)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                HStack {
                    Image(systemName: "sparkles")
                    Text("Crafting your idea...")
                }
                .font(.system(size: 28, weight: .bold, design: .rounded))
            }
            
            if let cocktailDescription = viewModel.cocktailIdea?.description {
                Text(cocktailDescription)
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)
                    .opacity(0.9)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    GetInspired()
        .environment(PatchBay.patch.makeCocktailViewModel())
}
