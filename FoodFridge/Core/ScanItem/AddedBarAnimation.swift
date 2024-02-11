//
//  AddedAnimation.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/10/24.
//

import SwiftUI

struct AddedBarAnimation: View {
    var isTapped  =  false
    //var item = "Test Item"
    var body: some View {
        Rectangle()
            .fill(Color(.button2))
            .overlay {
                Text("Added item to pantry")
            }
            .frame(height: 30)
            .cornerRadius(5)
            .offset(x: isTapped ?  0 : -500)
            .animation(.spring(response: 2, dampingFraction: 0.6), value: isTapped)
    }
}

#Preview {
    AddedBarAnimation()
}
