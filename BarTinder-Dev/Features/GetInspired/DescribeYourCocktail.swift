/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI sheet-like component where the user can type a word for Foundation Models to generate a cocktail.
*/

import SwiftUI

extension GetInspired {
    struct DescribeYourCocktail: View {
        @Environment(\.router) private var router
        @Environment(GenerableModel.self) private var model
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            @Bindable var model = model
            
            VStack(spacing: 16) {
                TextField("A word for your future idea", text: $model.word)
                    .frame(height: 20)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.tfbg.opacity(0.8), in: .capsule)
                    .onChange(of: model.word) { _, newValue in
                        if !newValue.isEmpty {
                            model.prewarm()
                        }
                    }
                
                Button("Generate your idea") {
                    Task(name: "Generate the AI cocktail") {
                        model.askForIdea()
                    }
                }
                .buttonStyle(GenerateButton(color: model.word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue))
                .disabled(model.word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                Button("Later") {
                    router.dismissSheet()
                }
                .buttonStyle(GenerateButton(color: .applered))
                Spacer()
            }
            .padding()
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    GetInspired.DescribeYourCocktail()
}

