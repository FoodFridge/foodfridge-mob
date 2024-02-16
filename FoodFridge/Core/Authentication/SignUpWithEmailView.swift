//
//  SignUpWithEmailView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/21/23.
//

import SwiftUI

struct SignUpWithEmailView: View {
    
    @ObservedObject var vm = SignUpWithEmailViewModel()
    //@State private var path = NavigationPath()
    @State var email = ""
    @State var name = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create account")
                    .font(.custom("CourierPrime-Bold", size: 35))
                
                VStack {
                    TextField("username", text: $name)
                        .AppTextFieldStyle()
                    TextField("email", text: $email)
                        .AppTextFieldStyle()
                    TextField("password", text: $password)
                        .AppTextFieldStyle()
                }
                
                Button {
                    //sign up user
                    Task {
                        try await vm.signUpUser
                    }
                    
                } label: {
                    Text("Sign up")
                }
                .bold()
                .foregroundStyle(.black)
                .frame(width: 150, height: 30)
                .background(Color(.button2))
                .cornerRadius(20)
                .padding(.bottom)
                
                
                VStack {
                    Text("By using the app, you agree to our Terms of use and Privacy policy")
                }
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .font(.custom("CourierPrime-Regular", size: 12))
                
                
            }
            
           
            }
                
        }
    
    
        
}
  #Preview
        {
            SignUpWithEmailView()
        }
