//
//  GoogleSignInButton.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/20/24.
//

import SwiftUI

struct GoogleSignInButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .foregroundStyle(.white)
                    .shadow(color: .gray, radius: 4, x: 0, y:2)
                
                Image("googleIcon")
                    .resizable()
                    .scaledToFit()
                    .mask( 
                        Circle()
                    )
                    
                }
            }
            .frame(width: 55, height: 55)
        }
}



 #Preview {
 GoogleSignInButton(action: {})
 }
 
