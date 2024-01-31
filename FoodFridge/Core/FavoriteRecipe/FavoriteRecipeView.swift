//
//  FavoriteRecipeView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import SwiftUI

struct FavoriteRecipeView: View {
    
    var title: String = "Salmon with Ginger Glaze"
    var googleRecipes = GoogleSearchRecipe.mockGoogleSearchRecipes
    @State private var LinkRecipes = [LinkRecipe]()
    @State private var isLiked = false
    @ObservedObject var vm = FavoriteRecipeViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.listOfFavLinks) { linkRecipe in
                    GoogleLinkRow(googleLink: linkRecipe)
                }
                
            }.scrollIndicators(.hidden)
            
        }
        .onAppear {
            Task {
                //vm.listOfgoogleLinks  = try await vm.getLinkRecipes(fromUserId: "test user", recipeName: title)
            }
        }
        
        
        Text("List of \(title) Recipes by google search")
        
    }
}

#Preview {
    FavoriteRecipeView()
}
