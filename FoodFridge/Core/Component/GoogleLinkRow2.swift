//
//  GoogleLinkRow2.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import SwiftUI

struct GoogleLinkRow2: View {
    var googleLink:  LinkRecipe2?
    @State private var isLiked: Bool = false
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            Rectangle()
            HStack {
                Button {
                    // tap to save/unsave
                    isLiked.toggle()
                    Task {
                        try await UpdateFavoriteRecipe.updateFavorite(linkId: googleLink?.id ?? "id", isFavorite: isLiked)
                    }
                } label: {
                    Image(systemName:  googleLink?.isFavorite == "Y"  ?  "heart.fill" : "heart" )
                        .foregroundStyle(.black)
                        .padding(10)
                }
                .onChange(of: isLiked) { newValue in
                    
                }
                
                Button {
                    // tap to navigate to google link
                    if let googleLink = URL(string: googleLink?.url ?? "url") {
                        openURL(googleLink)
                    }
                } label: {
                    VStack {
                        Text(googleLink?.title ?? "Title")
                            .foregroundStyle(.black)
                            .font(.custom(CustomFont.appFontRegular.rawValue, size: 13))
                            .padding()
                            .multilineTextAlignment(.leading)
                    }
                }
               
                Spacer()
                
                Button {
                    // tap to navigate to google link
                    if let googleLink = URL(string: googleLink?.url ?? "Link") {
                        openURL(googleLink)
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

#Preview {
    GoogleLinkRow2()
}

