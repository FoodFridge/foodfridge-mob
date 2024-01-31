//
//  RecipesView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct LinkRecipesView: View {
    
    var title: String = "Salmon with Ginger Glaze"
    var googleRecipes = GoogleSearchRecipe.mockGoogleSearchRecipes
    @State private var LinkRecipes = [LinkRecipe]()
    @State private var isLiked = false
    @ObservedObject var vm = LinkRecipesViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.listOfgoogleLinks) { linkRecipe in
                   
                    GoogleLinkRow(googleLink: linkRecipe, title: "", link: "", img: "", isLiked: $isLiked)
                }
            }.scrollIndicators(.hidden)
            
        }
        .onAppear {
            Task {
                vm.listOfgoogleLinks  = try await vm.getLinkRecipes(fromUserId: "test user", recipeName: title)
              
            }
        }
        
        
        Text("List of \(title) Recipes by google search")
        
    }
}

#Preview {
    LinkRecipesView()
}
