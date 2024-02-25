//
//  RecipesView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct LinkRecipesView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var LinkRecipes = [LinkRecipe]()
    @StateObject var vm = LinkRecipesViewModel()
    @StateObject var likeState = GoogleLinkRowViewModel()
    
    
    var title: String = "Salmon with Ginger Glaze"
    var googleRecipes = GoogleSearchRecipe.mockGoogleSearchRecipes
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.listOfgoogleLinks) { linkRecipe in
                    GoogleLinkRow(googleLink: linkRecipe, isLiked: linkRecipe.isFavorite == "Y" ? true : false, likeState: likeState)
                }
                
            }.scrollIndicators(.hidden)
            
        }
        .onAppear {
            Task {
                vm.listOfgoogleLinks  = try await vm.getLinkRecipes(fromUserId: "test user", recipeName: title)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                if sessionManager.isLoggedIn() {
                    NavigationLink {
                        //MARK: navigate to Profile view
                        ProfileView()
                    }label: {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(Color(.button2))
                    }
                }
                
                NavigationLink {
                    //MARK: navigate to Scan Item view
                    ScanItemView()
                }label: {
                    Image(systemName: "camera.circle")
                        .foregroundColor(Color(.button2))
                }
            }
        }
        
        RecipeAnimation(likeState: likeState)
        //Text("Testing : List of \(title) Recipes")
        
    }
}

#Preview {
    LinkRecipesView()
}
