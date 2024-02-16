//
//  SignUpWithEmailView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/21/23.
//

import SwiftUI

struct SignUpWithEmailView: View {
    
    @StateObject var vm = SignUpWithEmailViewModel()
    @EnvironmentObject var authenthication: Authentication
    //@State private var path = NavigationPath()
    @State private var isSignUpSuccess = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create account")
                    .font(.custom("CourierPrime-Bold", size: 35))
                
                VStack {
                    TextField("username", text: $vm.name)
                        .AppTextFieldStyle()
                    TextField("email", text: $vm.email)
                        .AppTextFieldStyle()
                    TextField("password", text: $vm.password)
                        .AppTextFieldStyle()
                }
                
                Button {
                    //sign up user
                    Task {
                        self.isSignUpSuccess = try await vm.signUpUser()
                        if isSignUpSuccess {
                            authenthication.updateValidation(success: true)
                        }
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
