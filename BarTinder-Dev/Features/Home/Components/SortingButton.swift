/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that provides filter buttons for cocktail sorting and filtering.
*/

import SwiftUI

extension Home {
    struct SortingScrollView: View {
        @Environment(HomeModel.self) private var model
        let title: String
        let filterOption: CocktailFilterPredicate
        
        var body: some View {
            Button(title) {
                withAnimation(.smooth) {
                    model.filterOption = filterOption
                }
            }
            .buttonStyle(.plain)
            .frame(height: 50)
            .foregroundStyle(model.filterOption == filterOption ? .selecText : .unselecText)
            .fontWeight(.medium)
       
            .padding(.horizontal)
           
            .bartinderRounder()
            .scaleEffect(model.filterOption == filterOption ? 1.02 : 1)
            .glassEffect(.regular.tint(model.filterOption == filterOption ? .selecBackground : .unselecBackground).interactive())
       
        }
    }
}

#Preview(traits: .barTinderEnvironments) {
    Home.SortingScrollView(title: "Gin", filterOption: CocktailFilterPredicate.gin)
}
