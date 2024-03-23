//
//  GoogleResultRow.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/26/24.
//

import SwiftUI

struct GoogleLinkRow: View {
    var googleLink:  LinkRecipe?
    @State var isLiked: Bool
    @State var nonLoggedInUserTapped = false
    @Environment(\.openURL) var openURL
    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var likeState: GoogleLinkRowViewModel
    
    var body: some View {
        
            ZStack {
                Rectangle()
                VStack {
                    HStack {
                        Button {
                            // non logged in user cannot like to save, will display warning to log in
                            if !sessionManager.isLoggedIn() {
                                isLiked = false
                                // trigger animation bar
                                likeState.isNonLoggedInTapped = true
                                // Reset the state after a delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                    likeState.isNonLoggedInTapped = false
                                }
                            }else {
                                // logged in user tap to save/unsave
                                isLiked.toggle()
                                
                                Task {
                                    try await UpdateFavoriteRecipe.updateFavorite(linkId: googleLink?.id ?? "id", isFavorite: isLiked)
                                }
                            }
                            
                            
                        } label: {
                            HStack {
                                Image(systemName: isLiked ?  "bookmark.fill" : "bookmark" )
                                    .foregroundStyle(.black)
                                    .padding(10)
                                Text(isLiked ? "Saved" : "Save")
                            }
                        }
                        
                        Spacer()
                    }
                    .offset(y: -5)
                    
                    //title link
                    NavigationLink {
                        // tap to navigate to google link
                        if let link = URL(string: googleLink?.url ?? "link") {
                            //openURL(googleLink)
                            WebView(url: link)
                                .navigationTitle("\(googleLink?.title ?? "Recipe")")
                                .navigationBarTitleDisplayMode(.inline)
                            
                        }
                    } label: {
                        VStack {
                            Text(googleLink?.title ?? "Recipe title")
                                .foregroundStyle(.black)
                                .font(.custom(CustomFont.appFontRegular.rawValue, size: 13))
                                .padding()
                                .multilineTextAlignment(.leading)
                                
                        }
                    }
       
                    
                    Spacer()
                
                   //Image link
                   NavigationLink {
                        // tap to navigate to google link
                        if let link = URL(string: googleLink?.url ?? "Link") {
                            //openURL(link)
                            WebView(url: link)
                                .navigationTitle("\(googleLink?.title ?? "https://www.twopeasandtheirpod.com/wp-content/uploads/2015/01/Peanut-Butter-Apple-Baked-Oatmeal-2.jpg")")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    } label: {
                        let url = URL(string: googleLink?.img ?? "https://spoonacular.com/recipeImages/86929-312x231.jpg")
                        // Check if the placeholder image exists. If not, use a system image or another safe default.
                        let placeholderImage = UIImage(named: "foodImage") ?? UIImage(systemName: "photo")!
                                
                        CachedAsyncImage(url: url, placeholder: placeholderImage)
                    }
                    
                }
                
            }
            
            .frame(width: 350, height: 100)
            .shadow(radius: 8, x: 5, y:5)
            .cornerRadius(10)
            .foregroundStyle(.button2)
        }
    }


/*
 #Preview {
 GoogleLinkRow(isLiked: .constant: true)
 }
 */
