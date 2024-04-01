//
//  ResultView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var vm: TagsViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var navigationController: NavigationController
   
    
    var body: some View {
        
        NavigationStack {
            //if got generate result
           if !vm.isLoading {
                if vm.generatedRecipes.count != 0 {
                    ScrollView {
                        VStack {
                            
                            Text("We've found Recipes!")
                                .padding(5)
                                .frame(width: 350, height: 45)
                                .background(.button2)
                                .cornerRadius(10)
                                .font(.custom(CustomFont.appFontBold.rawValue, size: 25))
                                .padding()
                        }
                        .padding()
                        ForEach(0..<vm.generatedRecipes.count, id: \.self) { index in
                            NavigationLink(destination: LinkRecipesView(sessionManager: sessionManager, title: vm.generatedRecipes[index].title)) {
                                RecipeRow(title: vm.generatedRecipes[index].title , imageURL: vm.generatedRecipes[index].image ?? "")
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }else {
                    //display no recipe found
                    VStack {
                        Image("cat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        VStack {
                            Text("No recipe.\nadd more ingredients and please try again.")
                                .multilineTextAlignment(.center)
                            NavigationLink {
                               LandingPageView()
                            }label: {
                                Text("Try again")
                                    .bold()
                                    .foregroundStyle(.button1)
                            }
                            .padding()
                        }
                        .padding()
                        .background(Rectangle().fill(Color.button2).cornerRadius(5))
                        .padding(.horizontal)
                        
                    }
                    .font(.custom(CustomFont.appFontRegular.rawValue, size: 17))
                }
            } else {
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

