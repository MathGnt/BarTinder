//
//  HomeView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 22/04/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Your Cocktails")
                    Spacer()
                }
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .padding(.leading, 18)
                .padding(.top, 30)
                
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
                Spacer()
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem {
                    Button {
                        
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
    HomeView()
}
