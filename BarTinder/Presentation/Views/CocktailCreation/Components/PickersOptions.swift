//
//  PickersOptions.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 01/06/2025.
//

import SwiftUI

struct PickersOptions: View {
    @Bindable var viewModel: CocktailCreationViewModel
    var body: some View {
        cocktailStylePicker
        cocktailGlassPicker
        cocktailPreparationPicker
        cocktailDifficultyPicker
        addToBarPicker
    }
}

private extension PickersOptions {
    
    private var cocktailStylePicker: some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 29, height: 27)
                    .foregroundStyle(.yellow)
                pickerImage(title: viewModel.cocktailStyle.rawValue, color: .yellow)
                
            }
            Picker("Cocktail Style", selection: $viewModel.cocktailStyle) {
                Text("Long Drink").tag(CocktailStyle.longDrink)
                Text("Short Drink").tag(CocktailStyle.shortDrink)
            }
        }
    }
    
    private var cocktailGlassPicker: some View {
        HStack(spacing: 15) {
            ZStack {
                pickerImage(title: viewModel.cocktailGlass.rawValue, color: .blue.opacity(0.6))
                
            }
            Picker("Cocktail Glass", selection: $viewModel.cocktailGlass) {
                ForEach(CocktailGlass.allCases) { glass in
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
                ForEach(CocktailPreparation.allCases) { method in
                    Text(method.rawValue.capitalized).tag(method)
                }
            }
        }
    }
    
    private var cocktailDifficultyPicker: some View {
        HStack(spacing: 15) {
            pickerImageSys(title: "gauge", color: .brown)
            
            Picker("Difficulty", selection: $viewModel.cocktailDifficulty) {
                Text("Easy").tag(CocktailDifficulty.easy)
                Text("Medium").tag(CocktailDifficulty.medium)
                Text("Hard").tag(CocktailDifficulty.hard)
                
            }
        }
    }
    
    private var addToBarPicker: some View {
        HStack(spacing: 15) {
            pickerImageSys(title: "wineglass", color: .applered)
            Toggle("Add To Bar", isOn: $viewModel.addToBar)
                .tint(.turborider)
        }
    }
    
    
    // Helper Views
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
    
    private func pickerImageSys(title: String, color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 29, height: 27)
                .foregroundStyle(color)
            Image(systemName: title)
                .resizable()
                .scaledToFit()
                .frame(height: 18)
                .foregroundStyle(.black)
        }
    }
}

