//
//  AddedAnimation.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/10/24.
//

import SwiftUI

struct AddedBarAnimation: View {
    
    @EnvironmentObject var sessionManager: SessionManager

    var isTapped  =  false
  
    var body: some View {
        Rectangle()
            .fill(Color(.button2))
            .overlay {
                Text(sessionManager.isLoggedIn() ? "Item added to your pantry" : "Please Sign in to use this feature")
                    .font(Font.custom(CustomFont.appFontBold.rawValue, size: 17))
            }
            .frame(height: 20)
            .cornerRadius(5)
            .offset(x: isTapped ?  0 : -500)
            .animation(.spring(response: 2, dampingFraction: 0.6), value: isTapped)
    }
}


#Preview {
    AddedBarAnimation()
}
