//
//  Swipe.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 16/04/2025.
//

import SwiftUI
import SwiftData

/// The first view of the app that shows many ingredient cards the user can swipe.
struct Swipe: View {
    @Environment(Storage.self) private var appStorage
    @State private var viewModel = PatchBay.patch.makeSwipeViewModel()
    
    var body: some View {
        ZStack {
                ZStack {
                    Color(.white)
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        VStack(spacing: 5) {
                            Image("centeredlogo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        ZStack {
                            ForEach(viewModel.ingredients.reversed()) { card in
                                IngredientCard(cardIngredient: card, viewModel: viewModel)
                            }
                        }
                        .onChange(of: viewModel.ingredients) { oldValue, newValue in
                            if !newValue.isEmpty { return }
                            viewModel.updatePossibleCocktails()
                            withAnimation(.easeIn) {
                                appStorage.hasFinshedSwiping = true
                            }
                        }
                        .animation(.easeInOut, value: appStorage.hasFinshedSwiping)
                        
                        HStack(spacing: 50) {
                            if let topCard = viewModel.ingredients.first {
                                BottomButtons(image: "xmark", color: .applered) {
                                    viewModel.triggerSwipeLeft(card: topCard)
                                }
                                BottomButtons(image: "wineglass.fill", color: .blue) {
                                    // Unused
                                }
                                .opacity(0)
                                BottomButtons(image: "heart.fill", color: .validate) {
                                    viewModel.triggerSwipeRight(card: topCard)
                                }
                            }
                        }
                        .frame(height: 100)
                    }
                }
                .onAppear {
                    if !appStorage.hasFetched {
                        viewModel.getCocktails()
                        appStorage.hasFetched = true
                    }
                }
                .transition(.opacity.combined(with: .scale))
        }
        .alert("Server Error", isPresented: $viewModel.fetchingError) {
            Button("Cancel") {}
        } message: {
            Text("Couldnt fetch cocktails for your selection")
        }
    }
}

#Preview {
    Swipe()
        .environment(Storage())
}





