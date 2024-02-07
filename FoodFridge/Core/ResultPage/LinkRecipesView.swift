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
    @StateObject var vm = LinkRecipesViewModel()
    
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.listOfgoogleLinks) { linkRecipe in
                    GoogleLinkRow(googleLink: linkRecipe, isLiked: linkRecipe.isFavorite == "Y" ? true : false)
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
                NavigationLink {
                    //MARK: navigate to Profile view
                    ProfileView()
                }label: {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(Color(.button2))
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
        
        
        Text("List of \(title) Recipes by google search")
        
    }
}

#Preview {
    LinkRecipesView()
}
