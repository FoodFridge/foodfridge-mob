//
//  FoodFridgeApp.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/20/23.
//

import SwiftUI

@main
struct FoodFridgeApp: App {
    @StateObject var authentication = Authentication()
    @StateObject var sessionManager = SessionManager()
    
    
    var body: some Scene {
        
        WindowGroup {
            NavigationStack{
                if authentication.isValidated || sessionManager.isLoggedIn() {
                    LandingPageView()
                        .environmentObject(sessionManager)
                        .environmentObject(authentication)
                        .environmentObject(TagsViewModel())
                        .environmentObject(ScanItemViewModel())
                        .environmentObject(SelectionSheetViewModel(sessionManager: sessionManager))
                        .environmentObject(ScrollTarget())
                    
                } else {
                    AuthenthicationView()
                        .environmentObject(sessionManager)
                        .environmentObject(authentication)
                        .environmentObject(TagsViewModel())
                        .environmentObject(ScanItemViewModel())
                        .environmentObject(SelectionSheetViewModel(sessionManager: sessionManager))
                        .environmentObject(ScrollTarget())
                }
            }
       
        }
    }
}
