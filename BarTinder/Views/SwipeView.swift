//
//  SwipeView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 16/04/2025.
//

import SwiftUI

struct SwipeView: View {
    
    @State private var viewModel: SwipeViewModel
    
    init(repo: CocktailRepo) {
        _viewModel = State(initialValue: SwipeViewModel(repo: repo))
    }
    
    var body: some View {
        if viewModel.finishSwiping == false {
           
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    VStack(spacing: 5) {
                        Image("centeredlogo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                       Spacer()
                    }
                    .padding(.horizontal)
        
                    ZStack {
                        ForEach(viewModel.ingredients.reversed()) { card in
                            CardView(card: card, viewModel: viewModel)
                        }
                    }
                    .onAppear {
                        viewModel.getCocktails()
                    }
                    .onChange(of: viewModel.ingredients) { oldValue, newValue in
                        if !newValue.isEmpty { return }
                        
                        viewModel.updatePossibleCocktails()
                        withAnimation(.default) {
                            viewModel.finishSwiping = true
                        }
                    }
                
                    HStack(spacing: 50) {
                        Button {
                            if let topCard = viewModel.ingredients.first {
                                viewModel.triggerSwipeLeft(card: topCard)
                            }
                          
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(height: 60)
                                    .foregroundStyle(.white)
                                    .shadow(radius: 5)
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.applered)
                            }
                        }
                        
                        Button {
        
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(height: 60)
                                    .foregroundStyle(.white)
                                    .shadow(radius: 5)
                                Image(systemName: "wineglass.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.blue)
                            }
                        }
                       
                        Button {
                            if let topCard = viewModel.ingredients.first {
                                viewModel.triggerSwipeRight(card: topCard)
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(height: 60)
                                    .foregroundStyle(.white)
                                    .shadow(radius: 5)
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 23, height: 20)
                                    .foregroundStyle(.green)
                                    .padding(.top, 3)
                            }
                        }
                    }
                    .frame(height: 100)
                }
            }
        } else {
            HomeView(swipeViewModel: viewModel)
                .animation(.default, value: viewModel.finishSwiping)
        }
    }
}

#Preview {
    SwipeView(repo: CocktailRepo(networkManager: NetworkManager()))
}
