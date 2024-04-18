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
    @Environment(\.colorScheme) var colorScheme
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
                                Text(isLiked ? "Saved!" : "Save recipe")
                            }
                            .padding(5)
                            .background(Rectangle().fill(Color.button1).cornerRadius(5))
                            .font(.callout)
                            .padding(.top,10)
                            .foregroundStyle(.white)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    
                    VStack {
                        //link image
                        Button {
                            // tap to navigate to google link
                            if let link = URL(string: googleLink?.url ?? "Link") {
                                openURL(link)
                                /*
                                WebView(url: link)
                                    .navigationTitle("\(googleLink?.title ?? "https://www.twopeasandtheirpod.com/wp-content/uploads/2015/01/Peanut-Butter-Apple-Baked-Oatmeal-2.jpg")")
                                    .navigationBarTitleDisplayMode(.inline)
                                 */
                            }
                        } label: {
                            //option1 : Use cached image form ui image: Benefit is display all loaded image at the same time when loaded done. Downside: Slower displaying screen compare to option#2     
                            /*
                            let url = URL(string: googleLink?.img ?? "https://spoonacular.com/recipeImages/86929-312x231.jpg")
                            // Check if the placeholder image exists from url provided. If not, use a system image or another safe default.
                            let placeholderImage = UIImage(named: "foodImage") ?? UIImage(systemName: "photo")!
                            
                            CachedAsyncImage(url: url, placeholder: placeholderImage)
                            */
                            
                            //option2 : AsyncImage : Benefit is more responsive displaying screen instantly when navigate to. Downside: Image have different loading time for each image) 
                            
                            AsyncImage(url: URL(string: googleLink?.img ?? "https://www.twopeasandtheirpod.com/wp-content/uploads/2015/01/Peanut-Butter-Apple-Baked-Oatmeal-2.jpg" )) { phase in
                                switch phase {
                                case .empty:
                                    // Placeholder when the image is not yet loaded
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill() // This ensures the image fill the frame //
                                        .frame(width: 300, height: 200) // Set the frame to consistency
                                        .clipped() // clip overflow to fit frame
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5, x: 5, y: 5)
                    
                                case .failure(_):
                                    // Placeholder or error handling when the image fails to load
                                    Image("foodImage")
                                        .resizable()
                                        .scaledToFill() // This ensures the image fill the frame //
                                        .frame(width: 300, height: 200) // Set the frame to consistency
                                        .clipped() // clip overflow to fit frame
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5, x: 5, y: 5)
                                        
                                @unknown default:
                                    // Placeholder or default handling for unknown cases
                                    Image(systemName: "foodImage")
                                        .resizable()
                                        .cornerRadius(10)
                                        .frame(maxWidth: 300, maxHeight: 200)
                                        .scaledToFit()
                                        .backgroundStyle(.white)
                                        .shadow(radius: 5, x: 5, y: 5)
                                }
                            }
                            
                        }
                        .aspectRatio(contentMode: .fit)
                        //.padding(.horizontal)
                       
                        
                        
                        //link title
                        Button {
                            // tap to navigate to google link
                            if let link = URL(string: googleLink?.url ?? "link") {
                                openURL(link)
                                //WebView(url: link)
                                    //.navigationTitle("\(googleLink?.title ?? "Recipe")")
                                    //.navigationBarTitleDisplayMode(.inline)
                                
                            }
                        } label: {
                            VStack {
                                Text(googleLink?.title ?? "Recipe title")
                                    
                                    //.lineLimit(4, reservesSpace: true)
                                    .foregroundStyle(.black)
                                    .font(.custom(CustomFont.appFontRegular.rawValue, size: 17))
                                    .padding()
                                    .multilineTextAlignment(.leading)
                                
                            }
                        }
                        
                        
                       
                        
                        
                      
                    }
                }
                
            }
            
            .frame(width: 350, height: 380)
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
