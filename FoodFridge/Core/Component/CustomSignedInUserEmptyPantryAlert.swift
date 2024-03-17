//
//  SignedInUserEmptyPantryAlert.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/16/24.
//

import SwiftUI

struct CustomSignedInUserEmptyPantryAlert: View {
    
    @Binding var isShow: Bool
    var sessionManager : SessionManager
    var buttonAction: () -> Void

    var body: some View {
        ZStack {
            Color.black
            
            VStack(spacing: 20) {
                Text("")
                    .font(.title)
                    .fontWeight(.bold)
                Text("How do you like to add pantry with?")
                    .bold()
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                VStack {
                    NavigationLink {
                        // navigate to camera
                        // ScanItemView2(vm: ScanItemViewModel(sessionManager: sessionManager))
                        ScanItemView()
                    } label: {
                        Text("By camera")
                            .bold()
                            .foregroundColor(.button1)
                            .padding(5)
                        //.background(Color.button1)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink {
                        // navigate to add pantry text
                        AddPantryView()
                    } label: {
                        Text("By text")
                            .bold()
                            .foregroundColor(.button2)
                            .padding(5)
                        //.background(Color.button1)
                            .cornerRadius(10)
                    }
                    
                    Button(action:  buttonAction,
                           label: {
                        Text("Not now")
                            .bold()
                            .foregroundColor(.red)
                            .padding(5)
                        //.background(Color.button1)
                            .cornerRadius(10)
                    })
                    
                    
                }
                
            }.padding()
            
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .frame(maxWidth: 300)
                .opacity(isShow ? 1 : 0)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CustomSignedInUserEmptyPantryAlert(isShow: .constant(true), sessionManager: SessionManager(), buttonAction: {})
}
