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
        //var item = "Test Item"
        var body: some View {
            Rectangle()
                .fill(Color(.button2))
                .overlay {
                    Text("Please Login to save your favorite!")
                }
                .frame(width: 300, height: 30)
                .cornerRadius(5)
                .offset(x: likeState.isNonLoggedInTapped ?  0 : -500)
                .animation(.spring(response: 2, dampingFraction: 0.6), value: likeState.isNonLoggedInTapped)
        }

}

#Preview {
    RecipeAnimation(likeState: GoogleLinkRowViewModel())
}
