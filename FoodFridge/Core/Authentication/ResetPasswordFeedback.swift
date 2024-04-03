//
//  ResetPasswordFeedback.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 4/2/24.
//

import SwiftUI

struct ResetPasswordFeedback: View {

    @EnvironmentObject var vm: ResetPasswordViewModel
    @State private var text = ""
    @State private var isShowingAlert = false
    @State private var isButtonOpenMailTapped = false
    @State private var isButtonSkipTapped = false
    @Environment(\.openURL) var openURL
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var sessionManager: SessionManager
    
    var popToRoot:() -> Void
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("mail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Check your email")
                    .font(.custom(CustomFont.appFontBold.rawValue, size: 30))
                //display email of user
                Text("\(vm.userEmailForFeedback)")
                VStack {
                    Text("We have sent a password recover instructions to you email. After reset password, you can use new password to log in.")
                        .multilineTextAlignment(.center)
                }.padding()
        
                //Open email button
                Button {
                    self.isButtonOpenMailTapped = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                        self.isButtonOpenMailTapped = false
                    }
                    
                    //verify if can support open email
                    if emailProviderIsSupport(email: vm.userEmailForFeedback) {
                        print("email suppoted")
                        //open email for user
                        openEmailInbox(email: vm.userEmailForFeedback)
                        print("opening email")
                    }else {
                        //else showing alert to user that we're not support the email
                        isShowingAlert = true
                    }
                    
                
                }label: {
                    Text("Open Email")
                        .font(.custom(CustomFont.appFontBold.rawValue, size: 22))
                        .foregroundColor(.black)
                }
                .bold()
                .padding(.vertical)
                .foregroundStyle(.black)
                .frame(width: 220, height: 50)
                .background(isButtonOpenMailTapped ? Color(.button2).opacity(0.5) : Color(.button2))
                .cornerRadius(20)
                .padding(.bottom)
                
                .alert("Unsupported Email Provider", isPresented: $isShowingAlert) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text("We're sorry, but we do not currently support your email provider.")
                        }
                
                
                Button {
                    self.isButtonSkipTapped = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                        self.isButtonSkipTapped = false
                    }
                    
                   popToRoot()
                }label: {
                    Text("Back to Login")
                        .font(.custom(CustomFont.appFontBold.rawValue, size: 22))
                        .foregroundColor(.black)
                }
                .bold()
                .padding(.vertical)
                .foregroundStyle(.black)
                .frame(width: 220, height: 50)
                .background(isButtonSkipTapped ? Color(.button2).opacity(0.5) : Color(.button2) )
                .cornerRadius(20)
                .padding(.bottom)
                
                Spacer()
                
                VStack{
                    Text("Did not recieve email? Check your spam folder,")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button {
                        dismiss()
                    }label: {
                        Text("Or try another email address")
                            .foregroundColor(Color(.button2))
                    }
                }
                .padding(.bottom, 10)
                
                
            }
            .font(.custom(CustomFont.appFontRegular.rawValue, size: 17))
            .foregroundStyle(colorScheme == .dark ? Color(.white) : Color(.black))
        }
        
        
    }
    
    func emailProviderIsSupport(email: String) -> Bool {
            let supportedProviders = ["gmail.com", "yahoo.com", "outlook.com", "icloud.com"]
            let emailDomain = email.split(separator: "@").last.map(String.init)
            
            if let domain = emailDomain, !supportedProviders.contains(domain) {
                // The email provider is not supported
                return false
            }else {
                //if email supported
                return true
            }
        }

    func openEmailInbox(email: String) {
            guard let domain = email.split(separator: "@").last else { return }
            print("domain = \(domain)")
            
            switch domain {
            case "gmail.com":
                let gmailURL = URL(string: "googlegmail://")!
                            if UIApplication.shared.canOpenURL(gmailURL) {
                                openURL(gmailURL)
                            } else {
                                // Fallback: Open Gmail in Safari if the app isn't installed
                                let webURL = URL(string: "https://mail.google.com/")!
                                openURL(webURL)
                            }
            case "yahoo.com":
                let yahooMailAppURL = URL(string: "yahoo-mail://")!
                          if UIApplication.shared.canOpenURL(yahooMailAppURL) {
                              openURL(yahooMailAppURL)
                          } else {
                              // Fallback: Open Yahoo Mail in the browser
                              let yahooMailWebURL = URL(string: "https://mail.yahoo.com")!
                              openURL(yahooMailWebURL)
                          }
            case "outlook.com":
                let outlookURL = URL(string: "ms-outlook://")!
                            if UIApplication.shared.canOpenURL(outlookURL) {
                                openURL(outlookURL)
                            } else {
                                // If Outlook isn't installed, open Outlook on the web.
                                let webURL = URL(string: "https://outlook.live.com/")!
                                openURL(webURL)
                            }
            case "icloud.com":
                openURL(URL(string: "https://www.icloud.com/mail")!)
            default:
                print("Email provider not recognized or unsupported")
                
            }
        }
}



#Preview {
    ResetPasswordFeedback(popToRoot: {})
}
