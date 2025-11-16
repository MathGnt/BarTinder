/*
See the LICENSE file for this project's licensing information.

Abstract:
A custom button style for the 'filter selection' buttons.
*/

import SwiftUI

struct SortingButonStyle: ButtonStyle {
    @Environment(HomeModel.self) private var model
    let filterOption: CocktailFilterPredicate
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .frame(height: 45)
            .font(.system(size: 17, weight: .medium))
            .foregroundStyle(model.filterOption == filterOption ? .selecText : .unselecText)
            .padding(.horizontal, 15)
            .bartinderRounder()
            .glassEffect(.regular.tint(model.filterOption == filterOption ? .selecBackground : .unselecBackground).interactive())
            .scaleEffect(model.filterOption == filterOption ? 1.03 : 1)
    }
}
