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

        var body: some View {
            NavigationStack {
                if navigateToLandingPage {
                    // Programmatically navigate to LandingPageView
                    LandingPageView()
                } else {
                    // Initial view (work around to programmatically navigate to landingpage to fix bug in prompt(tags displaying) 
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
