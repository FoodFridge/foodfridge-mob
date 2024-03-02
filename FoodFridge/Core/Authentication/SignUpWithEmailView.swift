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
    @EnvironmentObject var sessionManager: SessionManager
   
    @State private var isSignUpSuccess = false
    @State private var isPassHidden = true
    
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
                    
                    HStack {
                        if isPassHidden {
                            SecureField("password", text: $vm.password)
                                .AppTextFieldStyle()
                        }else {
                            TextField("password", text: $vm.password)
                                .AppTextFieldStyle()
                        }
                    }.overlay(alignment: .trailing) {
                        Image(systemName:  isPassHidden ? "eye.slash" : "eye")
                            .onTapGesture {
                                isPassHidden.toggle()
                            }
                            .padding(.horizontal, 30)
                    }
                }
                
                
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        //dismiss keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    
                    //sign up user
                    Task {
                        self.isSignUpSuccess = try await vm.signUpUser(sessionManager: sessionManager)
                        if isSignUpSuccess {
                            authenthication.updateValidation(success: true)
                            if vm.sessionData.token != nil && vm .sessionData.localId != nil {
                                //save session data
                                sessionManager.saveAuthToken(token: vm.sessionData.token ?? "mockToken")
                                sessionManager.saveLocalID(id: vm.sessionData.localId ?? "mockId")
                                
                            }
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
