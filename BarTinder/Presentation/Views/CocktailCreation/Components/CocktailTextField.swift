//
//  CocktailTextField.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 27/06/2025.
//

import Foundation
import SwiftUI

extension CreateEditCocktail {
    /// A blueprint for the pickers to select the cocktail options.
    struct CocktailTextField: View {
        @FocusState.Binding var focus: Focus?
        
        let title: String
        let binding: Binding<String>
        let axis: Axis
        let config: CreationTextFieldConfig
        
        var body: some View {
            TextField(title, text: binding, axis: axis)
                .characterLimit(config.characterLimit, text: binding)
                .keyboardType(config.keyboardType)
                .focused($focus, equals: config.focus)
                .submitLabel(config.submitLabel)
                .onSubmit {
                    focus = config.onSumbit
                }
        }
    }
    
    enum CreationTextFieldConfig {
        case name
        case description
        case abv
        case flavor
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .abv: return .numberPad
            default: return .default
            }
        }
        
        var focus: Focus? {
            switch self {
            case .name:
                return .name
            case .description:
                return .description
            case .abv:
                return.abv
            case .flavor:
                return .flavor
            }
        }
        
        var characterLimit: Int {
            switch self {
            case .name: return 30
            case .description: return 180
            case .abv: return 3
            case .flavor: return 15
            }
        }
        
        var submitLabel: SubmitLabel {
            switch self {
            case .name:
                return .next
            case .description:
                return .done
            case .abv:
                return .next
            case .flavor:
                return .done
            }
        }
        
        var onSumbit: Focus? {
            switch self {
            case .name:
                return .description
            case .description:
                return .abv
            case .abv:
                return .flavor
            case .flavor:
                return nil
            }
        }
    }
}
