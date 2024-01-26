//
//  ResultView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct ResultView: View {
    
    @State private var generatedRecipes: [Recipe] = Recipe.mockRecipes
    
    var body: some View {
        
        VStack {
            VStack {
                Text("We've found Recipes!")
                    .padding(5)
                    .frame(width: 350, height: 45)
                    .background(.button2)
                    .cornerRadius(19)
                    .font(.custom(CustomFont.appFontBold.rawValue, size: 25))
                    .padding()
            }
            
            .padding()
            
            ScrollView {
                ForEach(0..<generatedRecipes.count, id: \.self) { index in
                    NavigationLink(destination: RecipesView(title: generatedRecipes[index].title)) {
                        RecipeRow(title: generatedRecipes[index].title , imageURL: generatedRecipes[index].image)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
       
    }
}

#Preview {
    ResultView()
}
