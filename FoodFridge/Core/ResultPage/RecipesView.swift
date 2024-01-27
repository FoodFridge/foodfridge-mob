//
//  RecipesView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct RecipesView: View {
    var title: String = "Salmon with Ginger Glaze"
    var googleRecipes = GoogleSearchRecipe.mockGoogleSearchRecipes
    @State private var isLiked = false
    var body: some View {
        VStack {
            ScrollView {
                ForEach(googleRecipes) { recipe in
                   
                    GoogleResultRow(title: recipe.title, link: recipe.link, img: recipe.img, isLiked: $isLiked)
                }
            }.scrollIndicators(.hidden)
            
        }
        
        
        Text("List of \(title) Recipes by google search")
        
    }
}

#Preview {
    RecipesView()
}
