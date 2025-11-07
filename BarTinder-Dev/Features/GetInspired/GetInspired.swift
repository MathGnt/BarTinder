/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI sheet handling different 'generate' content depending on the user's action.
*/

import SwiftUI

struct GetInspired: View {
    @State private var model = GenerableModel()
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
        .environment(model)
    }
}

#Preview {
    GetInspired(inspiredDetent: .constant(.height(260)))
}
