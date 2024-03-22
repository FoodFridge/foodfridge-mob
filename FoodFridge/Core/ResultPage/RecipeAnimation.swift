//
//  RecipeAnimation.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/24/24.
//

import SwiftUI

struct RecipeAnimation: View {

        @EnvironmentObject var sessionManager: SessionManager
        @ObservedObject var likeState: GoogleLinkRowViewModel
        var isTapped  =  false
        var body: some View {
            Rectangle()
                .fill(Color(.button2))
                .overlay {
                    Text("Please Sign in to save your favorite!")
                        .padding(.horizontal, 5)
                        .font(Font.custom(CustomFont.appFontBold.rawValue, size: 14))
                }
                .frame(width: 350, height: 30)
                .cornerRadius(5)
                .offset(x: likeState.isNonLoggedInTapped ?  0 : -500)
                .animation(.spring(response: 2, dampingFraction: 0.6), value: likeState.isNonLoggedInTapped)
        }

}

#Preview {
    RecipeAnimation(likeState: GoogleLinkRowViewModel())
}
