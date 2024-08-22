//
//  AuthenticationTextField.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import SwiftUI

struct AuthTextFieldModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
                   content
                       .padding()
                       .frame(height: 40)
                       .foregroundColor(colorScheme == .dark ? Color(.button4) : Color(.button1))
                       .background(colorScheme == .dark ? Color(.button1) : Color(.button3))
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
