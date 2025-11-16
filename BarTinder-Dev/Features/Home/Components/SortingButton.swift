/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that provides filter buttons for cocktail sorting and filtering.
*/

import SwiftUI

extension Home {
    struct SortingButton: View {
        @Environment(HomeModel.self) private var model
        let title: String
        let filterOption: CocktailFilterPredicate
        
        var body: some View {
            Button(title) {
                withAnimation(.smooth) {
                    model.filterOption = filterOption
                }
            }
            .buttonStyle(SortingButonStyle(filterOption: filterOption))
            .accessibilityHint("Cocktails are sorted by \(title)")
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    Home.SortingButton(title: "Gin", filterOption: CocktailFilterPredicate.gin)
}
