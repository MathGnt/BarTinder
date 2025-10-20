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
    @State private var model = PatchBay.patch.makeSwipeModel()
    
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
                                .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                                .accessibilityHidden(true)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        ZStack {
                            ForEach(model.ingredients.reversed()) { card in
                                IngredientCard(cardIngredient: card, model: model)
                            }
                        }
                        .onChange(of: model.ingredients) { _, newValue in
                            if !newValue.isEmpty { return }
                            model.updatePossibleCocktails()
                            withAnimation(.easeIn) {
                                appStorage.hasFinshedSwiping = true
                            }
                        }
                        .animation(.easeInOut, value: appStorage.hasFinshedSwiping)
                        
                        HStack(spacing: 50) {
                            if let topCard = model.ingredients.first {
                                BottomButtons(image: "xmark", color: .applered) {
                                    model.triggerSwipeLeft(card: topCard)
                                }
                                BottomButtons(image: "wineglass.fill", color: .blue) {
                                    // Unused
                                }
                                .opacity(0)
                                BottomButtons(image: "heart.fill", color: .validate) {
                                    model.triggerSwipeRight(card: topCard)
                                }
                            }
                        }
                        .frame(height: 100)
                    }
                }
                .onAppear {
                    if !appStorage.hasFetched {
                        model.getCocktails()
                        appStorage.hasFetched = true
                    }
                }
                .transition(.opacity.combined(with: .scale))
        }
        .alert("Server Error", isPresented: $model.fetchingError) {
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





