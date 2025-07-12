//
//  CocktailPreviewHeader.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/06/2025.
//

import SwiftUI
import PhotosUI

extension CreateEditCocktail {
    struct CocktailPreviewHeader: View {
        @Environment(CreationModel.self) private var model
        
        let selectedImage: Binding<PhotosPickerItem?>
        let cocktail: Cocktail
        
        var body: some View {
            @Bindable var model = model
            
            let image = model.imageDataToUI(cocktail) /* Swift 6 scoped */
            HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
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
                .task(id: model.selectedPic) {
                    await model.loadSelectedImage(cocktail)
                }
                .alert("Loading error", isPresented: $model.photosError) {
                    Button("Cancel", role: .cancel) {}
                    Button("Retry") {
                        Task {
                            await model.loadSelectedImage(cocktail)
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
}

private struct PhotoPlaceHolder: View {
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


#Preview {
    CreateEditCocktail.CocktailPreviewHeader(selectedImage: .constant(nil), cocktail: Cocktail.ginto)
        .environment(PatchBay.patch.makeCreationModel())
}
