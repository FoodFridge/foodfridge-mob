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
    @State private var userData: LogInResponseData.LogInData = LogInResponseData.MOCKdata.data
    
    @State private var isLoggedIn = false
   
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome back!")
                    .font(.custom("CourierPrime-Bold", size: 35))
                
                VStack {
                    
                    TextField("email", text: $vm.email)
                        .AppTextFieldStyle()
                    
                    VStack {
                        TextField("password", text: $vm.password)
                            .AppTextFieldStyle()
                        HStack {
                            Spacer()
                            NavigationLink {
                                ForgotPasswordView()
                            }label: {
                                Text("Forgot password?")
                            }
                            .font(.custom("CourierPrime-regular", size: 13))
                            .padding(.trailing, 25)
                            .padding(.top, -20)
                            
                            
                            
                        
                        }
                    }
                }
                
                
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        //dismiss keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    
                    //login user
                    Task {
                        self.userData = try await LoginWithEmailService().login(email: vm.email, password: vm.password)
                        if self.userData.token != nil && self.userData.localId != nil {
                            sessionManager.saveAuthToken(token: userData.token ?? "mockToken")
                            sessionManager.saveLocalID(id: userData.localId ?? "mockId")
                            print("saved token = \(String(describing: sessionManager.getAuthToken()))")
                            print("saved local id = \(String(describing: sessionManager.getLocalID()))")
                            self.isLoggedIn = sessionManager.isLoggedIn()
                            if isLoggedIn {
                                authenthication.updateValidation(success: true)
                                
                            }
                        }
                    }
                    
                    
                } label: {
                    Text("Log in")
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
