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
    @StateObject private var appState = AppState()
    
    @Environment(\.scenePhase) var scenePhase
    
    
    @AppStorage("emailSignIn") var isEmailSignIn = false
    @AppStorage("userLoggedIn") var isLoggedIn = false
    
    
    var body: some Scene {
        
        WindowGroup {
            
                if isLoggedIn  {
                    GreetingView()
                        .environmentObject(appState)
                        .environmentObject(sessionManager)
                        .environmentObject(authentication)
                        .environmentObject(TagsViewModel(sessionManager: sessionManager))
                        .environmentObject(ScanItemViewModel(sessionManager: sessionManager))
                        .environmentObject(SelectionSheetViewModel(sessionManager: sessionManager))
                        .environmentObject(ScrollTarget())
                        
                        
                        
                      
                       
                    
                }else {
                    OnBoardingScreen()
                    //AuthenticationView(appleSignIn: AppleSignInHelper(sessionManager: sessionManager))
                        .environmentObject(appState)
                        .environmentObject(sessionManager)
                        .environmentObject(authentication)
                        .environmentObject(TagsViewModel(sessionManager: sessionManager))
                        .environmentObject(ScanItemViewModel(sessionManager: sessionManager))
                        .environmentObject(SelectionSheetViewModel(sessionManager: sessionManager))
                        .environmentObject(ScrollTarget())
                        
                        
                }
            
            
            
        
       
        } 
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive || newPhase == .background {
                print("newPhase == inactive or background")
                let currentTime = Date()
                UserDefaults.standard.set(currentTime, forKey: "lastActiveTime")// Call the function when the app becomes active
                appState.appDidBecomeActive(sessionManager: sessionManager)
            }
            
            
            else if newPhase == .active {
                print("newPhase == active")
                appState.appDidBecomeActive(sessionManager: sessionManager)
            }
             
              
        }
        
        
        
    }
    
}
