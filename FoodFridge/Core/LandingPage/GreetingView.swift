//
//  GreetingView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/18/24.
//

import SwiftUI

struct GreetingView: View {
    
        @State private var navigateToLandingPage = false
        @State private var hasNavigated = false // Prevent multiple navigations
        
        @State private var path: [Int] = []
        var body: some View {
            NavigationStack {
                if navigateToLandingPage {
                    // we want Initial view as Landing page this working around to programmatically navigate to landingpage. this file purpose is to fix bug in prompt(tags displaying))
                    LandingPageView(popToRoot:  { path.removeAll() })
                
                } else {
                    Text("Welcome back, Food Fridie!")
                        .onAppear {
                            if !hasNavigated {
                                navigateToLandingPage = true
                                hasNavigated = true
                            }
                        }
                }
            }
        }
    
}




#Preview {
    GreetingView()
}
