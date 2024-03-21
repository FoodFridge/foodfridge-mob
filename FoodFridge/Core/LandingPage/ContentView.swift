//
//  ContentView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var navigateToLandingPage = false
    @State private var hasNavigated = false // Prevent multiple navigations
    @State private var showSplashScreen = false
    @State private var path: [Int] = []
    @EnvironmentObject var sessionManager : SessionManager
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        //this view to verify that user been active to use app? to fetch new token when app not active for 1 day
        VStack {
            
            if  appState.showSplashScreen {
                SplashScreen()
            } else {
                LandingPageView()
               // LandingPageView(popToRoot: {path.removeAll()})
            }
            
        }
        
    }
    
    
}



class AppState: ObservableObject {
    
    @Published var showSplashScreen = false
    //@Published var isFirstLaunch : Bool
    
    init() {
        /*
        // Determine if this is the first launch, e.g., by checking UserDefaults
        isFirstLaunch = UserDefaults.standard.bool(forKey: "HasLaunchedOnce") == false
            if isFirstLaunch {
                   // Mark that the app has been launched once
                   UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
                   UserDefaults.standard.synchronize()
            }
         */
        
        // Initial check to set splash screen state based on elapsed time since last active
        let shouldShowSplash = shouldShowSplashOnStart()
        showSplashScreen = shouldShowSplash
    }
    
    func appDidBecomeActive(sessionManager: SessionManager) {
        
        // Perform the check again in case the state needs to be updated after becoming active
        let shouldShowSplash = shouldShowSplashOnStart()
        if shouldShowSplash {
            showSplashScreen = true
            
            let userTimezone = UserTimeZone.getTimeZone()
            let expTime = sessionManager.getExpTime()
            
            // Hide the splash screen after the desired duration
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showSplashScreen = false
                // after 2 seconds Proceed to show the main page
                Task {
                    //request new token and loadData
                   try await TokenManager.verifyTokenAndRequestNewToken(expTime: expTime ?? Date().timeIntervalSince1970, userTimeZone: userTimezone, sessionManager: sessionManager)
                }
            }
        }
    }
    
    
    private func shouldShowSplashOnStart() -> Bool {
        guard let lastActiveTime = UserDefaults.standard.object(forKey: "lastActiveTime") as? Date else {
            return false
        }
        if let lastActiveTime = UserDefaults.standard.object(forKey: "lastActiveTime") as? Date {
            print("Last Active Time: \(lastActiveTime)")
        } else {
            print("No Last Active Time Found")
        }
        
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(lastActiveTime)
        
        return elapsedTime > 5 // 172800 seconds in 2 days
    }
    
    
}




#Preview {
    ContentView()
}
