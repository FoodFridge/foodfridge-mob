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
                Rectangle()
                    .cornerRadius(120)
                    .foregroundStyle(.white)
                    .shadow(color: .gray, radius: 1, x: 0, y:0)
                HStack(spacing: 2.5) {
                    Spacer()
                    Image("googleIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                    Text("Sign in with Google")
                        .bold()
                        .foregroundStyle(.black)
                    Spacer()
                }
                }
            }
        .frame(width: 330, height: 50)
        }
}



 #Preview {
 GoogleSignInButton(action: {})
 }
 
