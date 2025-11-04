/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI sheet handling different 'generate' content depending on the user's action.
*/

import SwiftUI

struct GetInspired: View {
    @State private var model = GenerableModel()
    
    var body: some View {
        Group {
            if model.askedForIdea {
                GeneratedCocktail()
            } else {
                DescribeYourCocktail()
            }
        }
        .animation(.default, value: model.askedForIdea)
        .environment(model)
    }
}

#Preview {
    GetInspired()
}
