// Keaw test
// keaw test agian to confirm
//  LogInView.swift
//  FoodFridgec
//
//  Created by Jessie Pastan on 12/21/23.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var authenthication: Authentication
    
    @StateObject var vm = LogInWithEmailViewModel()
    @StateObject var validator = ValidateField()
    @State private var userData: LogInResponseData.LogInData = LogInResponseData.MOCKdata.data
    
    @State private var isPassHidden = true
   
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State var navigationPath = [Int]()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack(path: $navigationPath){
            VStack {
                Text("Welcome back!")
                    .font(.custom("CourierPrime-Bold", size: 35))
                
                VStack {
                    
                    TextField("email", text: $vm.email)
                        .AppTextFieldStyle()
                    
                    VStack {
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
                        
                        
                        
                        HStack {
                            Spacer()
                            Button {
                                navigationPath.append(1)
                               
                            }label: {
                                Text("Forgot password?")
                            }
                            .font(.custom("CourierPrime-regular", size: 13))
                            .padding(.trailing, 25)
                            .padding(.top, -20)
                            .navigationDestination(for: Int.self) { index in
                                switch index{
                                case 1:
                                    ResetPasswordView(popToRoot: {navigationPath.removeAll()})
                                default:
                                    EmptyView()
                                }
                            }
                            
                        }
                    }
                }
                
                
                Button {
                    //validate textfield
                    let isFieldValidated =  validator.validateTextField(email: vm.email, password: vm.password, name: nil)
                    print("validated = \(isFieldValidated)")
                    
                    if isFieldValidated {
                        
                        //login user
                        Task {
                           let isLoggedIn = try await vm.logIn(sessionManager: sessionManager)
                                if isLoggedIn {
                                    
                                }else {
                                    self.alertMessage =  vm.loginError?.errorDescription ?? "Failed to login. Please try again"
                                    self.showAlert = true
                                }
                        }
                    //if validate is failed
                    }else {
                        self.alertMessage = validator.fieldError?.textErrorDescription ?? "An error occor"
                        self.showAlert = true
                    }
                    
                    
                } label: {
                    Text("Log in")
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                .bold()
                .padding(.vertical)
                .foregroundStyle(.black)
                .frame(width: 150, height: 30)
                .background(Color(.button2))
                .cornerRadius(20)
                .padding(.bottom)
                
                
                
                
                
                
            }
        }
    }
    
}

#Preview {
    LogInView()
}
