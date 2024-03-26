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
    @State private var searchMenu = ""
    @ObservedObject var vm: FavoriteRecipeViewModel
    
    init(sessionManager: SessionManager) {
        self.vm = FavoriteRecipeViewModel(sessionManager: sessionManager)
    }
    
    var body: some View {
        VStack {
            if !vm.listOfFavLinks.isEmpty {
                ScrollView {
                    // Looping through the recipes array
                    VStack {
                        ForEach(vm.listOfFavLinks, id: \.self) { recipe in
                            VStack(alignment: .leading) {
                                Text("\(recipe.recipeName)")
                                    .font(Font.custom(CustomFont.appFontBold.rawValue, size: 20))
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .padding(.trailing, 5)
                            .padding(.bottom, -5)
                            .padding(.top, 20)
                            
                            
                            ForEach(recipe.recipeLinks, id: \.self) { recipeLink in
                                FavLinkRow(googleLink: recipeLink)
                            }
                            
                        }
                        
                    }
                    
                }
                .scrollIndicators(.hidden)
                
            
            }else if vm.isLoading {
                ProgressView()

            }else {
                VStack {
                    Text("No favorite yet").font(Font.custom(CustomFont.appFontRegular.rawValue, size: 17))
                    Image(systemName: "heart")
                        .foregroundStyle(Color.button4)
                        .bold()
                        .font(.title)
                }
            }
        }
        .onAppear {
                Task {
                    try await vm.getFavoriteRecipe(isFavorite: "Y")
                }
            }
        }
}

#Preview {
    FavoriteRecipeView(sessionManager: SessionManager())
}
