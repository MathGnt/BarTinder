//
//  GetInspiredCard.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/07/2025.
//

import SwiftUI

struct GetInspiredCard: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("appleintelligence")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 460, alignment: .bottom)
            
            Image("appleintelligence")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 460, alignment: .bottom)
                .blur(radius: 12, opaque: true)
                .brightness(0.2)
                .mask {
                    Rectangle()
                        .fill(
                            Gradient(stops: [
                                .init(color: .white, location: 0.0),
                                .init(color: .clear, location: 0.5)
                            ])
                        )
                }
            
            VStack(alignment: .leading) {
                Text(" Intelligence")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                
                HStack {
                    Text("Ask for")
                    Text("a")
                        .foregroundStyle(.gray)
                        .saturation(1.4)
                    Text("New idea")
                        .foregroundStyle(.gray)
                }
                .fontWeight(.semibold)
                
            }
            .font(.system(size: 35))
            .foregroundStyle(.white)
            .padding()
        }
        .frame(height: 450)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))

    }
}

#Preview {
    GetInspiredCard()
}
