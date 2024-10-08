//
//  ResultView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct ResultView: View {
    
    
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var navigationController: NavigationController
    @Environment(\.scenePhase) var scenePhase
    @State private var showProgressView = true
    @StateObject var viewModel: ResultViewModel
    @StateObject var likeState = GoogleLinkRowViewModel()
    
  
    var body: some View {
        
        NavigationStack {
            if !viewModel.isLoading {
                if viewModel.recipes.count != 0 {
                    ScrollView {
                        VStack {
                            Text("We've found what you can cook!")
                                .padding()
                                .lineLimit(2, reservesSpace: true)
                                .multilineTextAlignment(.center)
                                .padding(5)
                                .frame(width: 350, height: 65)
                                .background(.button2)
                                .cornerRadius(10)
                                .font(.custom(CustomFont.appFontBold.rawValue, size: 25))
                                .padding()
                        }
                        .padding()
                        
                        
                        
                        ForEach(viewModel.recipes, id: \.self) { recipe in
                            //Text("recipe = \(recipe.title)")
                            /*
                            NavigationLink(destination: LinkRecipesView(sessionManager: sessionManager, title: recipe.title)) {
                                RecipeRow(title: recipe.title , imageURL: recipe.img)
                            }
                             */
                           
                            RecipeRow(edamanRecipe: recipe, isLiked: recipe.isFavorite == "Y" ? true : false, likeState: likeState)
                        }
                        
                    }
                    .scrollIndicators(.hidden)
                }else {
                    //no recipe found display
                    CannotFindRecipeView()
                }
            }
            else {
                ProgressView()
            }
            
        }
        .onAppear {
                //Task {
                    //GenerateRecipe.getRecipe(from:)
                //}
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
                }else {
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
        // show animated bar to let user sign in before save recipe
        RecipeAnimation(likeState: likeState)
    }
}

