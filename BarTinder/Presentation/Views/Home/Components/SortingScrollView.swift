//
//  ScrollBarItem.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI

struct SortingScrollView: View {
    let viewModel: CocktailViewModel
    
    let title: String
    let filterOption: CocktailFilterCategory
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Button(title) {
            withAnimation(.smooth) {
                viewModel.filterOption = filterOption
            }
        }
        .foregroundStyle(.white)
        .frame(width: width, height: height)
        .background(viewModel.filterOption == filterOption ? .applered : .gray.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.bottom, 5)
        .scaleEffect(viewModel.filterOption == filterOption ? 1.05 : 1)
    }
}
