//
//  ResetPasswordFeedback.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 4/2/24.
//

import SwiftUI

struct ResetPasswordFeedback: View {

    @StateObject var vm  =  ForgotPasswordViewModel()
    @State private var text = ""
    @Environment(\.openURL) var openURL
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        NavigationStack{
            VStack {
                Image("mail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("Check your email!")
                    .font(.custom(CustomFont.appFontBold.rawValue, size: 25))
                Text("We have sent a password recover instructions to you email")
                
                Button {
                    //open email
                    let gmailURL = URL(string: "googlegmail://")!
                                if UIApplication.shared.canOpenURL(gmailURL) {
                                    openURL(gmailURL)
                                } else {
                                    // Fallback: Open Gmail in Safari if the app isn't installed
                                    let webURL = URL(string: "https://mail.google.com/")!
                                    openURL(webURL)
                                }
                    /*
                    if let url = URL(string: "mailto:\(vm.email)") {
                        open
                     */
                }label: {
                    Text("Open Email")
                        .foregroundColor(Color(.button1))
                }
                .padding()
                
                Button {
                   dismiss()
                }label: {
                    Text("Skip for now, I'll confirm later")
                        .foregroundColor(Color(.button1))
                }
                .padding()
                
                
                
                Text("Did not recieve email? Check your spam folder")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button {
                    dismiss()
                }label: {
                    Text("Or try another email address")
                        .foregroundColor(Color(.button2))
                }
                
            }.font(.custom(CustomFont.appFontRegular.rawValue, size: 17))
                .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
        }
        
        
    }
}

#Preview {
    ResetPasswordFeedback(vm: ForgotPasswordViewModel())
}
