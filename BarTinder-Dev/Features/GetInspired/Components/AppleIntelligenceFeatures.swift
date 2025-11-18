/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI component presenting the Apple Intelligence features.
*/

import SwiftUI

extension GetInspired {
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
}

extension GetInspired.AppleIntelligenceFeatures {
    struct PresentationText: View {
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
}

#Preview(traits: .modelsEnvironment) {
    GetInspired.AppleIntelligenceFeatures()
}
