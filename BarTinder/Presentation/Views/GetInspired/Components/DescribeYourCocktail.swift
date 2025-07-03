//
//  DescribeYourCocktail.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/07/2025.
//

import SwiftUI

struct DescribeYourCocktail: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: GenerableViewModel
    @Binding var currentDetent: PresentationDetent
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            TextField("A word for your future idea", text: $viewModel.word)
                .frame(height: 20)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.tfbg)
                .clipShape(RoundedRectangle(cornerRadius: 50))
            
            Button("Generate your idea") {
                Task {
                    viewModel.notGenerated = false
                    currentDetent = .large
                    await viewModel.generate()
                }
            }
            .buttonStyle(GenerateButton(color: .blue))
        }
        .padding()
    }
}

#Preview {
    DescribeYourCocktail(viewModel: GenerableViewModel(), currentDetent: .constant(.large))
}




