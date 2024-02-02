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
                    FavLinkRow(googleLink: linkRecipe)
                }
            }
            .scrollIndicators(.hidden)
            
        }
        .onAppear {
                Task {
                    vm.listOfFavLinks =  try await GetFavoriteRecipe.getLinkRecipe(userId: "test user", isFavorite: "Y")
                }
            }
        }
}

#Preview {
    FavoriteRecipeView()
}
