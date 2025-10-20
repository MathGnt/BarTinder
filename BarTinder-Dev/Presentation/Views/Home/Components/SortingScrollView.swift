//
//  SortingScrollView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI

extension Home {
    /// A menu bar to sort and filter the cocktails.
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
            .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
            .scaleEffect(model.filterOption == filterOption ? 1.02 : 1)
        }
    }
}

#Preview {
    Home.SortingScrollView(title: "Gin", filterOption: CocktailFilterPredicate.gin)
        .environment(PatchBay.patch.makeCocktailModel())
}
