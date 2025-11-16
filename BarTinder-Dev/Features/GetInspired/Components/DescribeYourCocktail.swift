/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI TextField component where the user can type a word for Foundation Models to generate a cocktail.
*/

import SwiftUI

extension GetInspired.CreateAppleIntelligence {
    struct DescribeYourCocktail: View {
        @Environment(\.router) private var router
        @Environment(GenerableModel.self) private var model
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            @Bindable var model = model
            
            VStack(spacing: 16) {
                TextField("Enter a word or flavor", text: $model.word)
                    .frame(height: 20)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.tfbg.opacity(0.8), in: .capsule)
                    .onChange(of: model.word) { _, newValue in
                        if !newValue.isEmpty {
                            model.prewarm()
                        }
                    }
                    .onSubmit {
                        if !model.word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            model.askForIdea()
                        }
                    }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview("Create", traits: .barTinderEnvironments) {
    GetInspired.CreateAppleIntelligence()
}



