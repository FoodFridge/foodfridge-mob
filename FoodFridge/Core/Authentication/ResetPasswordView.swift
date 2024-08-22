//
//  ForgotPasswordView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/23/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var vm: ResetPasswordViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var textField = ""
    @State private var navigateToNextpage = false
    @StateObject var validator = ValidateField()
    
    var popToRoot:() -> Void
    
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
                            
                            //reset text field to empty
                            vm.email = ""
                            print("email feedback = \(vm.userEmailForFeedback)")
                            
                            if vm.resetPasswordFeedback == 200 {
                                print("status = \(vm.resetPasswordFeedback)")
                                navigateToNextpage = true
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
                    //if return 200 go feedback page
                    ResetPasswordFeedback(popToRoot: popToRoot)
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
    ResetPasswordView(popToRoot: {})
}
