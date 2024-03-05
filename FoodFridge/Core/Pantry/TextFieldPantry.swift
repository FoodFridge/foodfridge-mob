//
//  TextFieldPantry.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/4/24.
//

import SwiftUI

struct TextFieldPantry: UIViewRepresentable {
        @Binding var text: String

        func makeUIView(context: Context) -> UITextField {
            let textField = UITextField()
            textField.delegate = context.coordinator
            return textField
        }

        func updateUIView(_ uiView: UITextField, context: Context) {
            uiView.text = text
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(text: $text)
        }

        class Coordinator: NSObject, UITextFieldDelegate {
            @Binding var text: String

            init(text: Binding<String>) {
                _text = text
            }

            func textFieldDidChangeSelection(_ textField: UITextField) {
                text = textField.text ?? ""
            }
        }
    }

#Preview {
    TextFieldPantry(text: .constant("text"))
}
