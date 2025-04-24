//
//  HomeView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var pushToBar = false
    @State var isSelected: Bool
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    HStack {
                        Button("Possible Cocktails") {
                            withAnimation(.smooth) {
                                viewModel.selectedCategory = .possibleCocktails
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 30)
                        .background(viewModel.selectedCategory == .possibleCocktails ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
    
                        Button("Gin") {
                            withAnimation(.smooth) {
                                viewModel.selectedCategory = .gin
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 30)
                        .background(viewModel.selectedCategory == .gin ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        Button("Vodka") {
                            withAnimation(.smooth) {
                                viewModel.selectedCategory = .vodka
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 70, height: 30)
                        .background(viewModel.selectedCategory == .vodka ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        Button("Vermouth") {
                            withAnimation(.smooth) {
                                viewModel.selectedCategory = .vermouth
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 30)
                        .background(viewModel.selectedCategory == .vermouth ? .applered : .gray.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
                
                HStack {
                    Text("Your Cocktails")
                    Spacer()
                }
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .padding(.horizontal, 18)
                .padding(.top, 15)
                
                ScrollView(.horizontal) {
                    HStack {
                        Rectangle()
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Rectangle()
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Rectangle()
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(18)
                Grid(horizontalSpacing: 150, verticalSpacing: 100) {
                    GridRow {
                        Text("test")
                        Text("test")
                    }
                    GridRow {
                        Text("test")
                        Text("test")
                    }
                }
                Spacer()
            }
            .navigationDestination(isPresented: $pushToBar, destination: {
                BarView()
            })
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem {
                    Button {
                        pushToBar = true
                    } label: {
                        Image(systemName: "wineglass")
                            .foregroundStyle(.limegreen)
                    }
                }
            }
        }
        
    }
}

#Preview {
    HomeView(isSelected: false)
}
