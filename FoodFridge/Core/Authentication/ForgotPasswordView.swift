//
//  ForgotPasswordView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/23/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var vm: ForgotPasswordViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToNextpage = false
    @StateObject var validator = ValidateField()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Reset password").font(.custom("CourierPrime-bold", size: 30))
                Text("Enter the email associate with your account.").font(.custom("CourierPrime-regular", size: 17))
                Text("We'll send an email with instructions to reset your password.").font(.custom("CourierPrime-regular", size: 17))
            }
            
            .padding()
            
                TextField("email", text: $vm.email)
                    .AppTextFieldStyle()
                Button(action: {
                    //validate text field
                    let isFieldValidated = validator.validateResetField(email: vm.email)
                    print("validated = \(isFieldValidated)")
                    //call api send email to reset password
                    if isFieldValidated {
                        print("can reset password")
                        Task {
                            let _ = try await vm.resetPassword(email: vm.email)
                            vm.email = ""
                            if vm.resetPasswordFeedback == 200 {
                                print("status = \(vm.resetPasswordFeedback)")
                                navigateToNextpage = true 
                                //self.alertMessage = "Sent reset password instruction to your email!"
                                //self.showAlert = true
                            }
                            else {
                                print("status = \(vm.resetPasswordFeedback)")
                                if vm.resetPasswordFeedback == 404 {
                                    self.alertMessage = "Not registered email, try another email"
                                    self.showAlert = true
                                }else if vm.resetPasswordFeedback == 500 {
                                    self.alertMessage = "Cannot reset password, please try again"
                                    self.showAlert = true
                                }
                                
                            }
                        }
                        
                        
                    }else {
                        self.alertMessage = validator.fieldResetError?.textErrorDescription ?? "An error occor"
                        self.showAlert = true
                    }
                    
                }, label: {
                    Text("Submit")
                })
                .sheet(isPresented: $navigateToNextpage, content: {
                    // feedback page
                    //TestView()
                    ResetPasswordFeedback()
                })
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

#Preview {
    ForgotPasswordView(vm: ForgotPasswordViewModel())
}
