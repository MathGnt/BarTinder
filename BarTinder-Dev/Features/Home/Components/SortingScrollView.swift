/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view component that provides filter buttons for cocktail sorting and filtering.
*/

import SwiftUI

extension Home {
    struct SortingScrollView: View {
        @Environment(CocktailModel.self) private var model
        let title: String
        let filterOption: CocktailFilterPredicate
        
        var body: some View {
            Button(title) {
                withAnimation(.smooth) {
                    model.filterOption = filterOption
                }
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(model.filterOption == filterOption ? .applered : .gray.opacity(0.6))
            .bartinderRounder()
            .scaleEffect(model.filterOption == filterOption ? 1.02 : 1)
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    Home.SortingScrollView(title: "Gin", filterOption: CocktailFilterPredicate.gin)
}
