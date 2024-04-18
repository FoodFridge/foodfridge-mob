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
            /*
            AsyncImage(url: URL(string: imageURL)) { phase in
                           switch phase {
                           case .empty:
                               // Placeholder for loading image
                               ProgressView()
                                   .frame(width: 300, height: 200)
                           case .success(let image):
                               image
                                   .resizable()
                                   .scaledToFill() // This ensures the image fill the frame //
                                   .frame(width: 300, height: 200) // Set the frame to consistency
                                   .clipped() // clip overflow to fit frame
                                   .background(Color.white)
                                   .cornerRadius(10)
                                   .shadow(radius: 8, x: 5, y: 5)
                           case .failure:
                               // Placeholder for failed image loading
                               Image(systemName: "foodImage")
                                   .frame(width: 300, height: 200)
                           @unknown default:
                               EmptyView()
                           }
                       }
             */
            
            Text(title)
                .foregroundStyle(.black)
                .padding(.horizontal)
                .font(.custom(CustomFont.appFontBold.rawValue, size: 18))
                .frame(width: 350, height: 70)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 8, x: 5, y: 5)
                .multilineTextAlignment(.center)
        }
        
        .padding(.bottom, 20)
        
       
    }
}

#Preview {
    RecipeRow()
}
