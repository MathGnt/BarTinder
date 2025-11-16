/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI sheet-like component where the user can type a word for Foundation Models to generate a cocktail.
*/

import SwiftUI


    struct AppleIntelligenceFeatures: View {
        var body: some View {
            VStack(alignment: .leading, spacing: BarTinderApp.Padding.bigTitleSpacingTop) {
                PresentationText(
                    title: "Propose an Idea",
                    description: "Type a word or idea, and let Apple Intelligence craft a unique cocktail just for you.",
                    image: "lightbulb"
                )
                
                PresentationText(
                    title: "Customize Your Creation",
                    description: "Edit the cocktail name, add a photo, or tweak ingredients to your taste.",
                    image: "rectangle.and.pencil.and.ellipsis"
                )
                
                PresentationText(
                    title: "Accept and Save",
                    description: "Approve your creation and add it directly to your cocktail collection.",
                    image: "checkmark"
                )
            }
        }
    }


private struct PresentationText: View {
    let title: String
    let description: String
    let image: String
    
    var body: some View {
        HStack(spacing: BarTinderApp.Padding.titleSpacingTop) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.pink)
                .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(description)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    AppleIntelligenceFeatures()
}



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


#Preview("Create", traits: .barTinderEnvironments) {
    GetInspired.CreateAppleIntelligence()
}


extension GetInspired {
    struct CreateAppleIntelligence: View {
        var body: some View {
            VStack(spacing: 30) {
                Spacer()
                header

                AppleIntelligenceFeatures()
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                DescribeYourCocktail()
                footer
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Spacer()
            }
         
        }
        private var header: some View {
            Text("Shake up your idea")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        
        private var footer: some View {
            VStack(spacing: 8) {
                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 20))

                Text("Apple Intelligence works entirely on your device, keeping your personal data private. All core features are processed offline, ensuring fast, seamless performance even without an internet connection. You can create, customize, and manage your cocktails safely and responsibly, while enjoying a fully personal experience.")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal)
        }
    }
}
