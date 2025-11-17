/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI sheet displaying all features related to Foundation Models as well as the input TextField.
*/

import SwiftUI

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

#Preview(traits: .barTinderEnvironments) {
    GetInspired.CreateAppleIntelligence()
}
