//
//  FoodFridgeApp.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/20/23.
//

import SwiftUI

@main
struct FoodFridgeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authentication = Authentication()
    @StateObject var sessionManager = SessionManager()
    
    @AppStorage("googleSignIn") var isGoogleSignIn = false
    @AppStorage("appleSignIn") var isAppleSignIn = false
   
    
    
    var body: some Scene {
        
        WindowGroup {
            
                if authentication.isValidated || sessionManager.isLoggedIn() || isGoogleSignIn || isAppleSignIn {
                    GreetingView()
                        .environmentObject(sessionManager)
                        .environmentObject(authentication)
                        .environmentObject(TagsViewModel())
                        .environmentObject(ScanItemViewModel(sessionManager: sessionManager))
                        .environmentObject(SelectionSheetViewModel(sessionManager: sessionManager))
                        .environmentObject(ScrollTarget())
                    
                } else {
                    AuthenthicationView(appleSignIn: AppleSignInHelper(sessionManager: sessionManager))
                        .environmentObject(sessionManager)
                        .environmentObject(authentication)
                        .environmentObject(TagsViewModel())
                        .environmentObject(ScanItemViewModel(sessionManager: sessionManager))
                        .environmentObject(SelectionSheetViewModel(sessionManager: sessionManager))
                        .environmentObject(ScrollTarget())
                }
            
            
            
        
       
        }
    }
}
