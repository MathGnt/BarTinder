//
//  SwipeView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 16/04/2025.
//

import SwiftUI
import SwiftData

struct SwipeView: View {
    
    @Environment(\.modelContext) private var context
    @State private var viewModel = PatchBay.patch.makeSwipeViewModel()
    @AppStorage("finish-swiping") private var finishSwiping: Bool = false
    
    var body: some View {
        ZStack {
            if finishSwiping == false {
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
                        
                        .onChange(of: viewModel.ingredients) { oldValue, newValue in
                            if !newValue.isEmpty { return }
                            
                            viewModel.updatePossibleCocktails()
                            withAnimation(.easeIn) {
                                finishSwiping = true
                            }
                            try? context.save()
                        }
                        .animation(.easeInOut, value: finishSwiping)
                        
                        HStack(spacing: 50) {
                            if let topCard = viewModel.ingredients.first {
                                bottomButtons(image: "xmark", color: .applered) {
                                    viewModel.triggerSwipeLeft(card: topCard)
                                }
                                
                                bottomButtons(image: "wineglass.fill", color: .blue) {
                                    // Unused
                                }
                                .opacity(0)
                                
                                bottomButtons(image: "heart.fill", color: .turborider) {
                                    viewModel.triggerSwipeRight(card: topCard)
                                }
                            }
                        }
                        .frame(height: 100)
                    }
                }
                .onAppear {
                    viewModel.getCocktails()
                }
                .transition(.opacity.combined(with: .scale))
            }
            
            
            if finishSwiping {
                HomeView(finishSwiping: $finishSwiping, swipeViewModel: viewModel)
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            }
            
        }
        .animation(.easeInOut(duration: 0.6), value: finishSwiping)
    }
}

#Preview {
    SwipeView()
}
    
    //MARK: - View Function

extension SwipeView {
    
    private func bottomButtons(image: String, color: Color, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .frame(height: 60)
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                Image(systemName: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: image != "wineglass.fill" ? 20 : 15, height: 20)
                    .foregroundStyle(color)
            }
        }
    }
}


