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
    
    let mockRecipes1 = ["A Christmas With Peking Duck", "Hunter's Duck","Asian Meatballs", "Duck Rumaki", "Black Truffle Caesar Salad","Duck with Dried Cranberries", "Tangerines and Mascarpone Sauce",  "Grilled Duck","Slow-roasted duck legs","Pan-Seared Duck With Blueberry Glaze","Baked Chicken Dijon"]
    let mockRecipes2 = ["Kappa Maki", "Nasi Pudina (Mint Rice)",  "Cardamon Infused Black Rice Pudding with Coconut Milk", "Cumin-Scented Basmati Rice Pilaf", "Thai-Style Sticky Rice & Mango Dessert Shots" , "Coconut Rice Pudding",  "Wild Rice With Bacon", "Mushrooms & Green Onions", "Chicken Rollintini with Pesto", "Baby Spinach & Brown Rice" ]
    
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
                        ForEach(mockRecipes2 , id: \.self) { recipe in
                            NavigationLink(destination: LinkRecipesView(sessionManager: sessionManager, title: recipe)) {
                                RecipeRow(title: recipe)
                            }
                        
                        }
                        
                        /*
                        ForEach(viewModel.recipes, id: \.self) { recipe in
                            NavigationLink(destination: LinkRecipesView(sessionManager: sessionManager, title: recipe.title)) {
                                RecipeRow(title: recipe.title , imageURL: recipe.img)
                            }
                         
                        }
                         */
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
        
        
    }
}

