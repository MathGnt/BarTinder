//
//  SortingScrollView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI

extension Home {
    
    struct SortingScrollView: View {
        @Environment(CocktailViewModel.self) private var viewModel
        
        let title: String
        let filterOption: CocktailFilterPredicate
        
        var body: some View {
            Button(title) {
                withAnimation(.smooth) {
                    viewModel.filterOption = filterOption
                }
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(viewModel.filterOption == filterOption ? .applered : .gray.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.bottom, 5)
            .scaleEffect(viewModel.filterOption == filterOption ? 1.05 : 1)
        }
    }
}
