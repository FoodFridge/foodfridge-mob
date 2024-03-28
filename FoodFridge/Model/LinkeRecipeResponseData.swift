//
//  LinkeRecipeResponseData.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/30/24.
//

import Foundation
struct LinkeRecipeResponseData: Codable {
    let data: [LinkRecipe]
}

 struct LinkRecipe: Codable, Identifiable {
    
    let id: String
    let title : String
    let img : String
    let isFavorite: String
    let recipeName: String?
    let url: String
    let userId: String?
    
    
    enum CodingKeys: String, CodingKey {
               case id = "favId"
               case title
               case img 
               case isFavorite
               case recipeName
               case url
               case userId
    }
}

extension LinkRecipe {
    static var mockLinkRecipes: [LinkRecipe] {
        [LinkRecipe(id: "1", title: "Pork omelet", img: "https://www.youtube.com/watch?v=J2hficUEUcE", isFavorite: "https://i.ytimg.com/vi/C5WBACYnSd8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBT5ZX6qXOgwmWy5o0Xvm_gJqOyqA", recipeName: "", url: "", userId: "test user"),
         LinkRecipe(id: "2", title: "Crispy Omelet", img: "https://www.youtube.com/watch?v=-6zXcZjSCE4", isFavorite: "https://i.ytimg.com/vi/C5WBACYnSd8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBT5ZX6qXOgwmWy5o0Xvm_gJqOyqA", recipeName: "", url: "", userId: "test user")
        ]
    }
    
    
    
    
    
}
