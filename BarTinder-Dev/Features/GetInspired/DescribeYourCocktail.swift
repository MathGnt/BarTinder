/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI sheet-like component where the user can type a word for Foundation Models to generate a cocktail.
*/

import SwiftUI

extension GetInspired {
    struct DescribeYourCocktail: View {
        @Environment(Router.self) private var router
        @Environment(GenerableModel.self) private var model
        @Environment(\.dismiss) private var dismiss
        @FocusState private var focus: Focus?
        
        var body: some View {
            @Bindable var model = model
            
            VStack(spacing: 16) {
                TextField("A word for your future idea", text: $model.word)
                    .focused($focus, equals: .word)
                    .frame(height: 20)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.tfbg.opacity(0.8), in: .capsule)
                    .onChange(of: focus) { _, newValue in
                        if newValue == .word {
                            model.prewarm()
                        }
                    }
                
                Button("Generate your idea") {
                    Task(name: "Generate the AI cocktail") {
                        model.askedForIdea = true
                    }
                }
                .buttonStyle(GenerateButton(color: model.word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue))
                .disabled(model.word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                Button("Later") {
                    focus = nil
                    router.dismissSheet()
                }
                .buttonStyle(GenerateButton(color: .applered))
                Spacer()
            }
            .padding()
            .alert("Not available", isPresented: $model.notAvailable) {
                Button("Ok", role: .cancel) {
                    focus = nil
                }
            } message: {
                Text("Apple intelligence is not available for your device")
            }
            .alert("Violated guardrail", isPresented: $model.guardrailViolation) {
                Button("Ok", role: .cancel) {
                    dismiss()
                }
            } message: {
                Text("You violated the guardrail of Apple Intelligence!")
            }
        }
    }
}

#Preview {
    GetInspired.DescribeYourCocktail()
        .environment(Router())
        .environment(GenerableModel())
}
