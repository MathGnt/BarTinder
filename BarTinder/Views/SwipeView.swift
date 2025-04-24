//
//  HomeView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 16/04/2025.
//

import SwiftUI

struct SwipeView: View {
    
    @State var viewModel: SwipeViewModel
    
    init(repo: CocktailRepo) {
        _viewModel = State(wrappedValue: SwipeViewModel(repo: repo))
    }
    var body: some View {
        Text("")
    }
}

#Preview {
    SwipeView(repo: CocktailRepo(networkManager: NetworkManager()))
}
