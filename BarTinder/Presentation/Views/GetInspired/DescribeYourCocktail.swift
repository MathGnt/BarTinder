//
//  DescribeYourCocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 03/07/2025.
//

import SwiftUI

extension Home {
    /// A sheet-like view that shows where the user can enter a world to generate a cocktail.
    struct DescribeYourCocktail: View {
        @Environment(\.dismiss) private var dismiss
        @State private var viewModel = PatchBay.patch.makeGenerableViewModel()
        @Binding var showNewIdeaSheet: Bool
        let namespace: Namespace.ID
        
        @FocusState private var focus: Focus?
        
        var body: some View {
            VStack(spacing: 16) {
                TextField("A word for your future idea", text: $viewModel.word)
                    .focused($focus, equals: .word)
                    .frame(height: 20)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.tfbg.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .onChange(of: focus) { _, newValue in
                        if newValue == .word {
                            viewModel.prewarm()
                        }
                    }
                
                Button("Generate your idea") {
                    Task {
                        await viewModel.generate()
                    }
                }
                .buttonStyle(GenerateButton(color: viewModel.word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue))
                .disabled(viewModel.word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                Button("Later") {
                    focus = nil
                    showNewIdeaSheet = false
                }
                .buttonStyle(GenerateButton(color: .applered))
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.pushToAI) {
                GetInspired(showNewIdeaSheet: $showNewIdeaSheet)
                    .navigationTransition(.zoom(sourceID: ("get-inspired"), in: namespace))
                    .environment(viewModel)
            }
            .alert("Not available", isPresented: $viewModel.notAvailable) {
                Button("Ok", role: .cancel) {
                    focus = nil
                    showNewIdeaSheet = false
                }
            } message: {
                Text("Apple intelligence is not available for your device")
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    Home.DescribeYourCocktail(showNewIdeaSheet: .constant(true), namespace: namespace)
}
