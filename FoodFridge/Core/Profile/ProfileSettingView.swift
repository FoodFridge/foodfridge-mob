//
//  ProfileSetting.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/22/24.
//

import SwiftUI

enum Settings: String, CaseIterable {
    case SignOut = "Sign Out"
    case DeleteAccount = "Delete Account"
    case ContactUs = "Contact Us"
}


struct ProfileSettingView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var authentication: Authentication
    
    @State private var selectedSetting = ""
    @State private var isBlinking = false
    @State private var isSignedOut = false
    
    var body: some View {
        
        List {
            ForEach(Settings.allCases, id: \.self) { setting in
                Button(action: {
                    selectedSetting = setting.rawValue
                    handleSelection(for: setting)
                    triggerBlink()
                    isSignedOut = true
                }) {
                    Text(setting.rawValue)
                        .foregroundStyle(isBlinking && selectedSetting == setting.rawValue ? .red : .primary)
                }
                
            }
            
        }
    }
    
    
    
    func handleSelection(for setting: Settings) {
            switch setting {
            case .SignOut:
                print("Sign Out Tapped")
                
                Task {
                    do {
                        self.isSignedOut = try await LogOut(sessionManager: sessionManager).logUserOut()
                        print(isSignedOut)
                        if self.isSignedOut {
                            sessionManager.logout()
                            print("logged out")
                            authentication.updateValidation(success: false)

                            UserDefaults.standard.set(false, forKey: "emailSignIn")
                            UserDefaults.standard.set(false, forKey: "userLoggedIn")
                        }
                    }catch {
                        print("\(error.localizedDescription)")
                    }
                }
                
                            
                
            case .DeleteAccount:
               
                print("Delete Account Tapped")
                 
            case .ContactUs:
    
                print("Contact Us Tapped")
               
            }
        }
    
    
    func triggerBlink() {
           withAnimation(.easeInOut(duration: 0.5).repeatCount(0, autoreverses: true)) {
               isBlinking.toggle()
           }
           // Reset the state after the animation completes
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
               isBlinking = false
           }
       }
}

#Preview {
    ProfileSettingView()
}
