/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view component that displays picker options for customizing cocktail properties.
*/

import SwiftUI

extension CreateEditCocktail {
    struct CocktailOptionsSection: View {
        @Bindable var cocktail: Cocktail
        
        var body: some View {
            CocktailPicker(
                imageTitle: cocktail.style.rawValue,
                color: .yellow,
                system: false,
                pickerTitle: "Cocktail Style",
                selection: $cocktail.style
            ) { newValue in
                cocktail.styleValue = newValue.rawValue
            }
            
            CocktailPicker(
                imageTitle: cocktail.glass.rawValue,
                color: .blue.opacity(
                    0.6
                ),
                system: false,
                pickerTitle: "Cocktail Glass",
                selection: $cocktail.glass
            ) { newValue in
                cocktail.glassValue = newValue.rawValue
            }
            
            CocktailPicker(
                imageTitle: "wand.and.rays",
                color: .green,
                system: true,
                pickerTitle: "Mixing Technique",
                selection: $cocktail.mixingTechnique
            ) { newValue in
                cocktail.mixingTechniqueValue = newValue.rawValue
            }
            
            CocktailPicker(
                imageTitle: "gauge",
                color: .brown,
                system: true,
                pickerTitle: "Cocktail Difficulty",
                selection: $cocktail.difficulty
            ) { newValue in
                cocktail.difficultyValue = newValue.rawValue
            }
            
            HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                pickerImage(title: "wineglass", color: .applered, system: true)
                Toggle("Add To Bar", isOn: $cocktail.isInBar)
                    .tint(.turborider)
            }
        }
    }
}

extension CreateEditCocktail.CocktailOptionsSection {
    struct CocktailPicker<T: CaseIterable & Hashable & RawRepresentable>: View where T.RawValue == String {
        let imageTitle: String
        let color: Color
        let system: Bool
        let pickerTitle: String
        @Binding var selection: T
        let onChange: (T) -> Void
        
        var body: some View {
            HStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                pickerImage(title: imageTitle, color: color, system: system)
                Picker(pickerTitle, selection: $selection) {
                    ForEach(Array(T.allCases), id: \.self) { option in
                        Text(option.rawValue.capitalized).tag(option)
                    }
                }
                .onChange(of: selection) { _, newValue in
                    onChange(newValue)
                }
            }
        }
    }
}


fileprivate func pickerImage(title: String, color: Color, system: Bool) -> some View {
    RoundedRectangle(cornerRadius: 5)
        .frame(width: 29, height: 27)
        .foregroundStyle(color)
        .overlay {
            if system {
                Image(systemName: title)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 18)
                    .foregroundStyle(.black)
            } else {
                Image(title)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 23)
                    .foregroundStyle(.black)
            }
        }
}

#Preview(traits: .barTinderEnvironments) {
    List {
        CreateEditCocktail.CocktailOptionsSection(cocktail: Cocktail.ginto)
    }
}
