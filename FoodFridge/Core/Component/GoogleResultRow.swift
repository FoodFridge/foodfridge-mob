//
//  GoogleResultRow.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/26/24.
//

import SwiftUI

struct GoogleResultRow: View {
    
    var title: String
    var link: String
    var img: String
    @Binding var isLiked: Bool
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            Rectangle()
            HStack {
                Button {
                    // tap to save URL
                    isLiked.toggle()
                } label: {
                    Image(systemName:  isLiked ?  "heart.fill" : "heart" )
                        .foregroundStyle(.black)
                        .padding(10)
                }
                
                Button {
                    // tap to navigate to google link
                    if let googleLink = URL(string: link) {
                        openURL(googleLink)
                    }
                } label: {
                    VStack {
                        Text(title)
                            .foregroundStyle(.black)
                            .font(.custom(CustomFont.appFontRegular.rawValue, size: 17))
                            .padding()
                            .multilineTextAlignment(.leading)
                    }
                }
               
                Spacer()
                
                Button {
                    // tap to navigate to google link
                    if let googleLink = URL(string: link) {
                        openURL(googleLink)
                    }
                } label: {
                    AsyncImage(url: URL(string: img)) { phase in
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
    GoogleResultRow(title: "Soy Ginger Salmon {Fast, Healthy Asian Salmon Recipe ...", link: "https://www.wellplated.com/soy-ginger-salmon/", img: "https://www.wellplated.com/wp-content/uploads/2017/04/Baked-Soy-Ginger-Salmon.jpg", isLiked: .constant(false))
}
