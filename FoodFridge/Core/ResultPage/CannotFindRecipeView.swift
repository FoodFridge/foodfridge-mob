//
//  CannotFindRecipeView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 4/2/24.
//

import SwiftUI

struct CannotFindRecipeView: View {
    var body: some View {
        VStack {
            Image("cat")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            VStack {
                Text("No recipe.\nadd more ingredients and please try again.")
                    .multilineTextAlignment(.center)
                NavigationLink {
                    LandingPageView()
                }label: {
                    Text("Try again")
                        .bold()
                        .foregroundStyle(.button1)
                }
                .padding()
            }
            .padding()
            .background(Rectangle().fill(Color.button2).cornerRadius(5))
            .padding(.horizontal)
            
        }
        .font(.custom(CustomFont.appFontRegular.rawValue, size: 17))
    }
}

#Preview {
    CannotFindRecipeView()
}
