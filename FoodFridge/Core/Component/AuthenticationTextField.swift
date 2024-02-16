//
//  AuthenticationTextField.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import SwiftUI

struct AuthTextFieldModifier: ViewModifier {

    func body(content: Content) -> some View {
                   content
                       .padding()
                       .frame(height: 40)
                       .background(Color.button3)
                       .foregroundColor(.black)
                       .font(.custom("CourierPrime-Regular", size: 25))
                       .cornerRadius(150)
                       .frame(maxWidth: .infinity)
                       .padding()
               }
}

extension View {
    func AppTextFieldStyle() -> some View {
        self.modifier(AuthTextFieldModifier())
    }
}
