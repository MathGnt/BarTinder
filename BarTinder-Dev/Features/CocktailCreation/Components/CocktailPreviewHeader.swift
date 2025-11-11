/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that displays a cocktail preview header with photo picker functionality.
*/

import SwiftUI
import PhotosUI

extension CreateEditCocktail {
    struct CocktailPreviewSection: View {
        @Environment(CocktailCreationModel.self) private var model
        
        let selectedImage: Binding<PhotosPickerItem?>
        let cocktail: Cocktail
        
        var body: some View {
            @Bindable var model = model
            
            HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                PhotosPicker(selection: selectedImage, matching: .images) { [image = model.imageDataToUI(cocktail)] in
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
                        Task(name: "Load the cocktail image") {
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


#Preview(traits: .barTinderEnvironments) {
    CreateEditCocktail.CocktailPreviewSection(selectedImage: .constant(nil), cocktail: Cocktail.ginto)
}
