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
    
    var body: some View {
        ZStack {
            Rectangle()
            HStack {
                
                Image(systemName: "heart")
                    .foregroundStyle(.black)
                    .padding(10)
                
                Text(title)
                    .foregroundStyle(.black)
                    .font(.custom(CustomFont.appFontRegular.rawValue, size: 17))
                    .padding()
                Spacer()
                AsyncImage(url: URL(string: img)) { Image in
                    Image
                        .resizable()
                        .scaledToFit()
                        .backgroundStyle(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5, x: 5, y:5)
                        
                } placeholder: {
                    
                }
                .padding(.horizontal)
               
                    
                
                
            }
               
            
        }
        .frame(width: 350, height: 100)
        .shadow(radius: 8, x: 5, y:5)
        .cornerRadius(10)
        .foregroundStyle(.button2)
        
    }
}

#Preview {
    GoogleResultRow(title: "Soy Ginger Salmon {Fast, Healthy Asian Salmon Recipe ...", link: "https://www.wellplated.com/soy-ginger-salmon/", img: "https://www.wellplated.com/wp-content/uploads/2017/04/Baked-Soy-Ginger-Salmon.jpg")
}
