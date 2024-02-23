//
//  AppTextField.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/22/24.
//

import SwiftUI

struct AuthTextField: View {
    var placeHolder: String
    var isPasswordField: Bool 
    @Binding var text: String
    
    var body: some View {
        
        
        if isPasswordField {
            SecureField(placeHolder, text: $text)
                .padding()
                .frame(height: 40)
                .foregroundColor(.button1)
                .background(Color.button3)
                .font(.custom("CourierPrime-Regular", size: 25))
                .cornerRadius(150)
                .frame(maxWidth: .infinity)
                .padding()
            
        }
        else {
            TextField(placeHolder, text: $text)
                .textFieldStyle(.roundedBorder)
                
        }
    }
}

