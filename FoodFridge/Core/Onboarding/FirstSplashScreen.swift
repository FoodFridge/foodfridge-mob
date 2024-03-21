//
//  FirstSplashScreen.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/20/24.
//

import SwiftUI

struct FirstSplashScreen: View {
    @State private var isActive = false
   // @State var isFirstLaunch: Bool
    //@EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
     
            
        if isActive {
            
            OnBoardingScreen()
            
        }else {
            
            ZStack {
                //Screen background
                Color(.button2)
                //Animation
                LottieView(name: "FoodAnimation").frame(width: 200, height: 200)
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isActive = true
                }
            }
            .ignoresSafeArea()
            
        
        }
       
        
      
        
        
    }
}

/*
 #Preview {
 FirstSplashScreen(isFirstLaunch: true)
 }
 */
