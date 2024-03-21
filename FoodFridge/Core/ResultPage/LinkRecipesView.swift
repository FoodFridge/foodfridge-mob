//
//  RecipesView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct LinkRecipesView: View {
   
    @State private var LinkRecipes = [LinkRecipe]()
    @StateObject var vm: LinkRecipesViewModel
    @StateObject var likeState = GoogleLinkRowViewModel()
    @EnvironmentObject var navigationController: NavigationController
    
    var sessionManager: SessionManager
    var title: String
    var googleRecipes = GoogleSearchRecipe.mockGoogleSearchRecipes
    
    
    init(sessionManager: SessionManager, title: String) {
        self.sessionManager = sessionManager
        self.title = title
        _vm = StateObject(wrappedValue: LinkRecipesViewModel(sessionManager: sessionManager))
    }
    
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
                vm.listOfgoogleLinks  = try await vm.getLinkRecipes(recipeName: title)
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
                else {
                    NavigationLink {
                       //MARK: pop to Authen view
                        AuthenticationView(appleSignIn: AppleSignInHelper(sessionManager: sessionManager))
                    }label: {
                        Text("Sign in")
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
       
        
    }
}

/*
 #Preview {
 LinkRecipesView(sessionManager: SessionManager(), title: "Ginger Salmon", popToRoot: {})
 }
 */
