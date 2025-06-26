//
//  CocktailImagePicker.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/06/2025.
//

import SwiftUI
import PhotosUI

struct CocktailPreviewHeader: View {
    @Bindable var viewModel: CocktailCreationViewModel
    let selectedImage: Binding<PhotosPickerItem?>
    let cocktail: Cocktail
    
    var body: some View {
        let image = viewModel.imageDataToUI(cocktail) /* Swift 6 scoped */
        HStack(spacing: 15) {
            PhotosPicker(selection: selectedImage, matching: .images) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .clipped()
                } else {
                    PhotoPlaceHolder()
                }
            }
            .task(id: viewModel.selectedPic) {
                await viewModel.loadSelectedImage(cocktail)
            }
            .alert("Loading error", isPresented: $viewModel.photosError) {
                Button("Cancel", role: .cancel) {}
                Button("Retry") {
                    Task {
                        await viewModel.loadSelectedImage(cocktail)
                    }
                }
            } message: {
                Text("Error while loading this picture")
            }
            
            Text(cocktail.name)
                .font(.system(size: 23, weight: .semibold, design: .rounded))
        }
    }
}


struct PhotoPlaceHolder: View {
    var body: some View {
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

