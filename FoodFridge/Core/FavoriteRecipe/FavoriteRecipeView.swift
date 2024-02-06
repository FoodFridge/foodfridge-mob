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
                // Looping through the recipes array
                VStack{
                    ForEach(vm.listOfFavLinks, id: \.self) { recipe in
                        
                        Text("\(recipe.recipeName)")
                        
                        ForEach(recipe.recipeLinks, id: \.self) { recipeLink in
                              FavLinkRow(googleLink: recipeLink)
                        }
                        
                    }
                   
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
