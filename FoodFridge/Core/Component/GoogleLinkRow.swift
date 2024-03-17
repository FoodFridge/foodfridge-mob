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
                        Image(systemName: isLiked ?  "heart.fill" : "heart" )
                            .foregroundStyle(.black)
                            .padding(10)
                    }
                    
                    
      
                    NavigationLink {
                        // tap to navigate to google link
                        if let link = URL(string: googleLink?.url ?? "link") {
                            WebView(url: link)
                                .navigationTitle("\(googleLink?.title ?? "Recipe")")
                                .navigationBarTitleDisplayMode(.inline)
                            //openURL(googleLink)
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
                    
                    Button {
                        // tap to navigate to google link
                        if let link = URL(string: googleLink?.url ?? "Link") {
                            openURL(link)
                        }
                    } label: {
                        AsyncImage(url: URL(string: googleLink?.img ?? "image" )) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder when the image is not yet loaded
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(maxWidth: 70, maxHeight: 90)
                                    .scaledToFill()
                                    .backgroundStyle(.white)
                                    .shadow(radius: 5, x: 5, y: 5)
                            case .failure(_):
                                // Placeholder or error handling when the image fails to load
                                Image(systemName: "photo")
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(maxWidth: 70, maxHeight: 90)
                                    .scaledToFill()
                                    .backgroundStyle(.white)
                                    .shadow(radius: 5, x: 5, y: 5)
                            @unknown default:
                                // Placeholder or default handling for unknown cases
                                ProgressView()
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal)
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
