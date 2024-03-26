//
//  RecipeRow.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct RecipeRow: View {
    
    var title: String = "Salmon With Ginger Glaze"
    var imageURL: String = "https://spoonacular.com/recipeImages/86929-312x231.jpg"
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: imageURL)) { Image in
                Image
                    .resizable()
                    .scaledToFit()
                    .backgroundStyle(.white)
                    .cornerRadius(10)
                    .shadow(radius: 8, x: 5, y:5)
                 
            } placeholder: {
                
            }
            .frame(width: 300, height: 200)
            
            Text(title)
                .font(.custom(CustomFont.appFontBold.rawValue, size: 18))
                .frame(width: 300)
                .multilineTextAlignment(.center)
        }
        
        .padding(.bottom, 20)
        
       
    }
}

#Preview {
    RecipeRow()
}
