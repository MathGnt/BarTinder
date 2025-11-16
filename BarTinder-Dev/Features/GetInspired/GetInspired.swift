/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI sheet handling different 'generate' content depending on the user's action.
*/

import SwiftUI

struct GetInspired: View {
    @State private var model = GenerableModel()
    @Environment(\.router) private var router
    
    var body: some View {
        ZStack {
            if model.askedForIdea {
                GeneratedCocktail()
            } else {
                CreateAppleIntelligence()
            }
        }
        .animation(.default, value: model.askedForIdea)
        .alert(
            Text(model.errorDetails?.title ?? "Error"),
            isPresented: .isPresent($model.errorDetails),
            presenting: model.errorDetails
        ) { _ in
            Button("Ok", role: .cancel) {
                model.errorDetails = nil
                router.dismissSheet()
            }
        } message: { details in
            Text(details.message)
        }
        .environment(model)
    }
}

#Preview(traits: .barTinderEnvironments) {
    GetInspired()
}
