//
//  BottomButtons.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/06/2025.
//

import SwiftUI

extension Swipe {
    
    struct BottomButtons: View {
        let image: String
        let color: Color
        let action: () -> Void
        var body: some View {
            Button {
                action()
            } label: {
                Circle()
                    .frame(height: 60)
                    .foregroundStyle(.white)
                    .overlay {
                        Image(systemName: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: image != "wineglass.fill" ? 20 : 15, height: 20)
                            .foregroundStyle(color)
                    }
                
                
            }
            .glassEffect(.regular.tint(.applered).interactive())
        }
    }
    
}
