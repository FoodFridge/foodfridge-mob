//
//  GreetingView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/18/24.
//

import SwiftUI

struct GreetingView: View {
    
        @State private var navigateToContent = false
        @State private var hasNavigated = false // Prevent multiple navigations
        @State private var showSplashScreen = false
        
        @State private var path: [Int] = []
        @EnvironmentObject var sessionManager : SessionManager
    
    
    var body: some View {
        NavigationStack {
            // we want Initial view as Landing page this working around to programmatically navigate to landingpage. this file purpose is to fix bug in prompt(tags displaying missing after login))
            if navigateToContent {
                ContentView()
            }else {
                VStack {
                    Text("Greeting!")
                    
                }
                .onAppear {
                    if !hasNavigated {
                        navigateToContent = true
                        hasNavigated = true
                    }
                }
                
                
            }
            
            
        }
        
        
        
        /*
        
        NavigationStack {
            if navigateToLandingPage {
                // we want Initial view as Landing page this working around to programmatically navigate to landingpage. this file purpose is to fix bug in prompt(tags displaying))
                LandingPageView(popToRoot:  { path.removeAll() })
                
            } else {
                
                //Check if session expire, display splash screen to get new token before transition to landing page
                let userTimezone = UserTimeZone.getTimeZone()
                let expTime = sessionManager.getExpTime()
                let isTokenExpired = TokenManager.isTokenExpired(expiryDateUnix: expTime ?? Date().timeIntervalSince1970, userTimeZoneIdentifier: userTimezone)
                
                if isTokenExpired {
                    VStack {
                        SplashScreen()
                    }
                    .onAppear {
                        //request new token
                        Task {
                            try await TokenManager.verifyTokenAndRequestNewToken(expTime: expTime ?? Date().timeIntervalSince1970, userTimeZone: userTimezone, sessionManager: sessionManager)
                        }
                        //display 6 secs before navigate to landing page
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            if !hasNavigated {
                                navigateToLandingPage = true
                                hasNavigated = true
                            }
                        }
                    }
                }
                // if user session not expire yet just display their landing page
                else {
                    VStack {
                        Text("Welcome back food frigdie")
                    }
                    .onAppear {
                        if !hasNavigated {
                            navigateToLandingPage = true
                            hasNavigated = true
                        }
                    }
                }
                
            }
        }
        
        */
        
        
    }
    
}




#Preview {
    GreetingView()
}
