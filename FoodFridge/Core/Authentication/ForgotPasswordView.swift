//
//  ForgotPasswordView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/23/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var vm: ForgotPasswordViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""
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
                        
                        
                    }else {
                        self.alertMessage = validator.fieldResetError?.textErrorDescription ?? "An error occor"
                        self.showAlert = true
                    }
                    
                }, label: {
                    Text("Submit")
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
