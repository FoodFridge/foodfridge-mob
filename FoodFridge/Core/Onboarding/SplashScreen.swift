//
//  SplashScreen.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/19/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
       
            ZStack {
                //Screen background
                Color(colorScheme == .dark ? .black : .clear)
                //Animation
                LottieView(name: "FoodAnimation").frame(width: 200, height: 200)

            }
            .ignoresSafeArea()
            
    }
}

#Preview {
    SplashScreen()
}
