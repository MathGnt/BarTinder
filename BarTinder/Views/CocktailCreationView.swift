//
//  CocktailCreationView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 12/05/2025.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CocktailCreationView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = CocktailCreationViewModel()
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 15) {
                    PhotosPicker(selection: $viewModel.selectedPic, matching: .images) {
                        if let data = viewModel.selectedImage, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .clipped()
                        } else {
                            placeHolderPicture
                        }
                    }
                    .onChange(of: viewModel.selectedPic) { oldValue, newValue in
                        Task {
                           await viewModel.loadSelectedImage()
                        }
                    }
                    
                    Text(viewModel.cocktailName)
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                }
            }
            
            Section {
                TextField("Name", text: $viewModel.cocktailName)
                    .characterLimit(30, text: $viewModel.cocktailName)
                TextField("Description", text: $viewModel.cocktailDescription)
                    .lineLimit(5, reservesSpace: true)
            }
            
            Section {
                NavigationLink {
                    IngredientsListCreationElmt(viewModel: viewModel)
                } label: {
                    Text("Ingredients")
                }
                ForEach(viewModel.addedIngredients) { ingredient in
                    Text(ingredient.name.capitalizedWords)
                }
            }
            
            Section {
                TextField("ABV", text: $viewModel.cocktailAbv)
                    .keyboardType(.numberPad)
                TextField("Flavor", text: $viewModel.cocktailFlavor)
            }
            
            Section {
                cocktailStylePicker
                
                cocktailGlassPicker
                
                cocktailPreparationPicker
                
                cocktailDifficultyPicker
            }
            
            Section {
                HStack(spacing: 15) {
                    pickerImageSys(title: "wineglass", color: .applered)
                    Toggle("Add To Bar", isOn: $viewModel.addToBar)
                        .tint(.limegreen)
                }
            }
           
        }
        .navigationTitle("New Cocktail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    viewModel.createCocktail(context: context)
                    if !viewModel.isNotValid {
                        dismiss()
                    }
                } label: {
                    Text("Done")
                }
                .alert("Please complete all the fields", isPresented: $viewModel.isNotValid) {
                    Button("Ok", role: .cancel) { }
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
    
    //MARK: - View Properties and Functions
    
   private var placeHolderPicture: some View {
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
                .foregroundStyle(.black)
                
        }
    }
    
   private var cocktailStylePicker: some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 29, height: 27)
                    .foregroundStyle(.yellow)
                pickerImage(title: viewModel.cocktailStyle.rawValue, color: .yellow)
               
            }
            Picker("Cocktail Style", selection: $viewModel.cocktailStyle) {
                Text("Long Drink").tag(CocktailCreationViewModel.CocktailStyle.longDrink)
                Text("Short Drink").tag(CocktailCreationViewModel.CocktailStyle.shortDrink)
            }
        }
    }
    
    private var cocktailGlassPicker: some View {
        HStack(spacing: 15) {
            ZStack {
                pickerImage(title: viewModel.cocktailGlass.rawValue, color: .white)
               
            }
            Picker("Cocktail Glass", selection: $viewModel.cocktailGlass) {
                ForEach(CocktailCreationViewModel.CocktailGlass.allCases) { glass in
                    Text(glass.rawValue.capitalized).tag(glass)
                }
            }
        }
    }
    
    private var cocktailPreparationPicker: some View {
        HStack(spacing: 15) {
            ZStack {
                pickerImageSys(title: "wand.and.rays", color: .green)
            }
            Picker("Preparation Method", selection: $viewModel.cocktailPreparation) {
                ForEach(CocktailCreationViewModel.CocktailPreparation.allCases) { method in
                    Text(method.rawValue.capitalized).tag(method)
                }
            }
        }
    }
    
    private var cocktailDifficultyPicker: some View {
        HStack(spacing: 15) {
            pickerImageSys(title: "gauge", color: .brown)
            
            Picker("Difficulty", selection: $viewModel.cocktailDifficulty) {
                Text("Easy").tag(CocktailCreationViewModel.CocktailDifficulty.easy)
                Text("Medium").tag(CocktailCreationViewModel.CocktailDifficulty.medium)
                Text("Hard").tag(CocktailCreationViewModel.CocktailDifficulty.hard)
                
            }
        }
    }
    
    private func pickerImageSys(title: String, color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 29, height: 27)
                .foregroundStyle(color)
            Image(systemName: title)
                .frame(width: 23, height: 23)
                .foregroundStyle(.black)
        }
    }
    
    private func pickerImage(title: String, color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 29, height: 27)
                .foregroundStyle(color)
            Image(title)
                .resizable()
                .frame(width: 23, height: 23)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    CocktailCreationView()
}
