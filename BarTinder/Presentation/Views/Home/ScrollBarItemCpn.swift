//
//  ScrollBarItemCpn.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 29/05/2025.
//

import SwiftUI

struct ScrollBarItemCpn: View {
    let viewModel: CocktailViewModel
    
    let title: String
    let selectedCategory: Category
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Button(title) {
            withAnimation(.smooth) {
                viewModel.selectedCategory = selectedCategory
            }
        }
        .foregroundStyle(.white)
        .frame(width: width, height: height)
        .background(viewModel.selectedCategory == selectedCategory ? .applered : .gray.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.bottom, 5)
        .scaleEffect(viewModel.selectedCategory == selectedCategory ? 1.05 : 1)
    }
}
