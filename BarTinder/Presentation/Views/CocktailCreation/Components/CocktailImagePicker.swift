//
//  CocktailImagePicker.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/06/2025.
//

import SwiftUI
import PhotosUI

struct CocktailImagePicker: View {
    let viewModel: CocktailCreationViewModel
    let selectedImage: Binding<PhotosPickerItem?>
    
    var body: some View {
        let image = viewModel.imageDataToUI() /* Swift 6 scoped */
        
        PhotosPicker(selection: selectedImage, matching: .images) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .clipped()
            } else {
                ZStack {
                    Circle()
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
                        .frame(width: 75, height: 75)
                    
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .clipped()
                    Circle()
                        .trim(from: 0.67, to: 1)
                        .rotationEffect(.degrees(149.5))
                        .frame(height: 75)
                        .foregroundStyle(.black.opacity(0.5))
                    Text("Edit")
                        .offset(y: 27)
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                }
            }
        }
        .onChange(of: viewModel.selectedPic) { oldValue, newValue in
            Task {
                await viewModel.loadSelectedImage()
            }
        }
    }
}
