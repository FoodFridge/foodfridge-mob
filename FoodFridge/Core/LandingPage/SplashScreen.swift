//
//  SplashScreen.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/19/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
       
            VStack {
                LottieView(name: "FoodAnimation")
            }
            .frame(width: 200, height: 200)

    }
}

#Preview {
    SplashScreen()
}
