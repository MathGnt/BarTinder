/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI sheet handling different 'generate' content depending on the user's action.
*/

import SwiftUI

struct GetInspired: View {
    @State private var model = GenerableModel()
    @Environment(Router.self) private var router
    @Binding var inspiredDetent: PresentationDetent
    
    var body: some View {
        ZStack {
            if model.askedForIdea {
                GeneratedCocktail()
            } else {
                DescribeYourCocktail()
            }
        }
        .animation(.default, value: model.askedForIdea)
        .onChange(of: model.word) { _, newValue in
            if !newValue.isEmpty {
                inspiredDetent = .large
            } else {
                inspiredDetent = .height(260)
            }
        }
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
    @Previewable @State var inspiredDetent: PresentationDetent = .height(260)
    GetInspired(inspiredDetent: $inspiredDetent)
}
