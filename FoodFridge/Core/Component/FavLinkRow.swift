//
//  GoogleLinkRow2.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import SwiftUI

struct FavLinkRow: View {
    var googleLink:  RecipeLink?
    @State private var isLiked: Bool = true
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack  {
            Rectangle()
            VStack {
                // heart button
                HStack {
                    Button {
                        // tap to save/unsave
                        isLiked.toggle()
                        Task {
                            try await UpdateFavoriteRecipe.updateFavorite(linkId: googleLink?.id ?? "id", isFavorite: isLiked)
                        }
                    } label: {
                        Image(systemName:  isLiked  ?  "heart.fill" : "heart" )
                            .foregroundStyle(.black)
                            .padding(10)
                    }
                    //.offset(y: -5)
                    
                    Spacer()
                }
               
                
                VStack {
                    //Link Image
                    NavigationLink {
                        // tap to navigate to google link
                        if let link = URL(string: googleLink?.url ?? "url") {
                            //openURL(googleLink)
                            WebView(url: link)
                                .navigationTitle("\(googleLink?.title ?? "Recipe")")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    } label: {
                        
                        AsyncImage(url: URL(string: googleLink?.img ?? "https://www.twopeasandtheirpod.com/wp-content/uploads/2015/01/Peanut-Butter-Apple-Baked-Oatmeal-2.jpg" )) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder when the image is not yet loaded
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(maxWidth: 380, maxHeight: 280)
                                    .scaledToFit()
                                    .backgroundStyle(.white)
                                    .shadow(radius: 5, x: 5, y: 5)
                            case .failure(_):
                                // Placeholder or error handling when the image fails to load
                                Image("foodImage")
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(maxWidth: 380, maxHeight: 280)
                                    .scaledToFit()
                                    .backgroundStyle(.white)
                                    .shadow(radius: 5, x: 5, y: 5)
                            @unknown default:
                                // Placeholder or default handling for unknown cases
                                Image(systemName: "foodImage")
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(maxWidth: 380, maxHeight: 280)
                                    .scaledToFit()
                                    .backgroundStyle(.white)
                                    .shadow(radius: 5, x: 5, y: 5)
                            }
                        }
                        
                    }
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                   
                    
                    //Link title
                    NavigationLink {
                        // tap to navigate to google link
                        if let link = URL(string: googleLink?.url ?? "url") {
                            //openURL(googleLink)
                            WebView(url: link)
                                .navigationTitle("\(googleLink?.title ?? "Recipe")")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    } label: {
                        VStack {
                            Text(googleLink?.title ?? "Title")
                                .lineLimit(2)
                                .foregroundStyle(.black)
                                .font(.custom(CustomFont.appFontRegular.rawValue, size: 17))
                                .padding()
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    
                }
                
                
            }
            
        }
        .frame(width: 350, height: 350)
        .shadow(radius: 8, x: 5, y:5)
        .cornerRadius(10)
        .foregroundStyle(colorScheme == .dark ? .white : .button6)
        
        
        
        
      
    }
}

#Preview {
    FavLinkRow()
}

