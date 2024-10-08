//
//  SignUpWithEmailView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/21/23.
//

import SwiftUI

struct SignUpWithEmailView: View {
    
    @StateObject var validator = ValidateField()
    @StateObject var vm = SignUpWithEmailViewModel()
    @EnvironmentObject var authenthication: Authentication
    @EnvironmentObject var sessionManager: SessionManager
   
    @State private var isAuthenSuccess = false
    @State private var isPassHidden = true
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var signUpErrorAlert = false
    @State private var signUpErrorMessage = ""
    
    @State private var showPrivacyPolicy = false
    @State private var showTermOfUse = false
    
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
                    
                    let isFieldValidated = validator.validateTextField(email: vm.email, password: vm.password, name: vm.name)
                    print("sign up validated = \(isFieldValidated)")
                    if isFieldValidated {
                        //sign up user
                        Task {
                            do {
                                //AuthenSuccess = user can sign up then log in successfully
                                self.isAuthenSuccess = try await vm.signUpUser(sessionManager: sessionManager)
                                if isAuthenSuccess {
                                    authenthication.updateValidation(success: true)
                                    if vm.sessionData.token != nil && vm.sessionData.localId != nil {
                                        //save session data
                                        sessionManager.saveAuthToken(token: vm.sessionData.token ?? "mockToken")
                                        sessionManager.saveLocalID(id: vm.sessionData.localId ?? "mockId")
                                        
                                    }
                                }else  {
                                    //Cannot sign up and log in successfully
                                    // assign alert in message and display
                                    // handle sign up error
                                    self.alertMessage = vm.signupError?.errorDescription ?? "Failed to autenticate. Please try again"
                                    self.showAlert = true
                                }
                            }catch {
                                // handle
                                self.alertMessage = validator.fieldError?.textErrorDescription ?? "Failed to authenticate. Please try again"
                                self.showAlert = true
                            }
                        }
                        //if fields validation has failed, show alert
                    }else {
                        self.alertMessage = validator.fieldError?.textErrorDescription ?? "An unknown error occur"
                        self.showAlert = true
                    }
                    
                    
                } label: {
                    Text("Sign up")
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .bold()
                .foregroundStyle(.black)
                .frame(width: 150, height: 30)
                .background(Color(.button2))
                .cornerRadius(20)
                .padding(.bottom)
                
               
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Password setting with 6 digits and up.")
                        Text("By using the app, you agree to our ")
                    }
                    
                    HStack {
                        //show term of use
                        Button {
                            showTermOfUse = true
                        } label: {
                            Text("Terms of use")
                                .lineLimit(1)
                        }
                        .sheet(isPresented: $showTermOfUse, content: {
                            NavigationStack {
                                WebView(url: AppConstant.termOfUseLink!)
                                    .ignoresSafeArea()
                            }
                        })
                        //show privacy policy
                        Button {
                            showPrivacyPolicy = true
                        } label: {
                            Text("and Privacy policy")
                                .lineLimit(1)
                        }
                        .sheet(isPresented: $showPrivacyPolicy, content: {
                            NavigationStack {
                                WebView(url: AppConstant.privacyPolicyLink!)
                                    .ignoresSafeArea()
                                
                            }
                        })

                    }
                }
                .lineLimit(3)
                .font(.custom("CourierPrime-Regular", size: 12))
                .padding(.horizontal)
            }
            
            }
        }
    
    
        
}
  #Preview
        {
            SignUpWithEmailView()
        }
