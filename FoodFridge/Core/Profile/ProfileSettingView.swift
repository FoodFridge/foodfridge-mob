//
//  ProfileSetting.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/22/24.
//

import SwiftUI

enum Settings: String, CaseIterable {
    
    case signOut = "Sign out"
    case contactUs = "Contact us"
    case privacyPolicy = "Privacy policy"
    case termOfUse = "Term of use "
    case reviewUs = "Review us"
    
    var iconName: String {
        switch self {
        case .signOut:
            return "rectangle.portrait.and.arrow.right.fill"
        case .contactUs:
            return "envelope.fill"
        case .privacyPolicy:
            return "person.crop.rectangle"
        case .termOfUse:
            return "list.clipboard.fill"
        case .reviewUs:
            return "star.fill"
        }
    }
    
}


struct ProfileSettingView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var authentication: Authentication
    
    @State private var selectedSetting = ""
    @State private var isBlinking = false
    @State private var isSignedOut = false
    @State private var emailUs = false
    @State private var privacyPolicy = false
    @State private var TermOfUse = false
    
    
    
    var body: some View {
        VStack {
            List {
                ForEach(Settings.allCases, id: \.self) { setting in
                    Button(action: {
                        selectedSetting = setting.rawValue
                        handleSelection(for: setting)
                        triggerBlink()
                        
                    }) {
                        HStack {
                            //icon
                            Image(systemName: setting.iconName).bold()
                            //text
                            Text(setting.rawValue)
                        }
                        .foregroundStyle(determineColor(for: setting))
                    }
                    .sheet(isPresented: $privacyPolicy, content: {
                        NavigationStack {
                            WebView(url: AppConstant.privacyPolicyLink!)
                                .ignoresSafeArea()
                        }
                    })
                    .sheet(isPresented: $TermOfUse, content: {
                        NavigationStack {
                            WebView(url: AppConstant.termOfUseLink!)
                                .ignoresSafeArea()
                            
                        }
                    })
                    
                }
                
            }
        }
    }
               
    
    
    
    func handleSelection(for setting: Settings) {
            switch setting {
            case .signOut:
                print("Sign Out Tapped")
                //sign out user
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
                
                 
            case .contactUs:
                print("Contact Us tapped")
                //display email form
                Task {
                    self.emailUs = true
                    EmailController.shared.sendEmail(subject: "", body: "", to: "foodfridge.contact@gmail.com")
                }
                
                
            case .privacyPolicy:
                print("Privacy tapped")
                //display privacy policy
                privacyPolicy = true
            
                    
                
            case .termOfUse:
                print("Term of use tapped")
                //display term of use
                self.TermOfUse = true
                
            case .reviewUs:
                //Navigate user to app review
                self.TermOfUse = true 
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
    
    // Determine color based on the setting
    func determineColor(for setting: Settings) -> Color {
        if isBlinking {
            if setting == .signOut && selectedSetting == setting.rawValue {
                return .red // Make Sign Out red when selected
            } else if selectedSetting == setting.rawValue {
                return .button5
            } else {
                return .primary // Use the default color for unselected settings
            }
        }
        return .primary
    }
}

#Preview {
    ProfileSettingView()
}
