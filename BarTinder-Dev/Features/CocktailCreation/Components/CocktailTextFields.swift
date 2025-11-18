/*
 See the LICENSE file for this project's licensing information.
 
 Abstract:
 A SwiftUI view components that provides text fields for cocktail creation.
 */

import Foundation
import SwiftUI

extension CreateEditCocktail {
    struct NameUITextField: UIViewRepresentable {
        @Binding var text: String
        var placeholder: String = "Cocktail name"

        func makeCoordinator() -> Coordinator {
            Coordinator(text: $text)
        }

        func makeUIView(context: Context) -> UITextField {
            let textField = UITextField()
            textField.delegate = context.coordinator
            textField.placeholder = placeholder
            textField.clearButtonMode = .whileEditing
            textField.text = text
            textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            return textField
        }

        func updateUIView(_ uiView: UITextField, context: Context) {
            if uiView.text != text {
                uiView.text = text
            }
        }

        class Coordinator: NSObject, UITextFieldDelegate {
            @Binding var text: String

            init(text: Binding<String>) {
                self._text = text
            }

            func textFieldDidChangeSelection(_ textField: UITextField) {
                text = textField.text ?? ""
            }
        }
    }
    
    struct DescriptionTextField: View {
        @Binding var text: String
        
        var body: some View {
            TextField("Description", text: $text, axis: .vertical)
        }
    }
}

#Preview(traits: .modelsEnvironment) {
    @Previewable @State var text = "Cocktail"
    CreateEditCocktail.DescriptionTextField(text: $text)
}



