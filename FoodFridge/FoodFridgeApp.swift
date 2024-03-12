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
    
    @AppStorage("emailSignIn") var isEmailSignIn = false
    @AppStorage("userLoggedIn") var isLoggedIn = false
    
    
    var body: some Scene {
        
        WindowGroup {
            
                if isLoggedIn  {
                    GreetingView()
                        .environmentObject(sessionManager)
                        .environmentObject(authentication)
                        .environmentObject(TagsViewModel(sessionManager: sessionManager))
                        .environmentObject(ScanItemViewModel(sessionManager: sessionManager))
                        .environmentObject(SelectionSheetViewModel(sessionManager: sessionManager))
                        .environmentObject(ScrollTarget())
                    
                } else {
                    AuthenthicationView(appleSignIn: AppleSignInHelper(sessionManager: sessionManager)) 
                        .environmentObject(sessionManager)
                        .environmentObject(authentication)
                        .environmentObject(TagsViewModel(sessionManager: sessionManager))
                        .environmentObject(ScanItemViewModel(sessionManager: sessionManager))
                        .environmentObject(SelectionSheetViewModel(sessionManager: sessionManager))
                        .environmentObject(ScrollTarget())
                }
            
            
            
        
       
        }
    }
}
