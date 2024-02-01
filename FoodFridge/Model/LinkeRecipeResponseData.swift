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
    let link: String?
    let img : String
    let isFavorite: String?
    let recipeName: String?
    let url: String?
    
    
    enum CodingKeys: String, CodingKey {
               case id = "fav_id"
               case title
               case link
               case img 
               case isFavorite
               case recipeName
               case url
    }
}

extension LinkRecipe {
    static var mockLinkRecipes: [LinkRecipe] {
        [LinkRecipe(id: "1", title: "Pork omelet", link: "https://www.youtube.com/watch?v=J2hficUEUcE", img: "https://i.ytimg.com/vi/C5WBACYnSd8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBT5ZX6qXOgwmWy5o0Xvm_gJqOyqA", isFavorite: "", recipeName: "", url: ""),
         LinkRecipe(id: "2", title: "Crispy Omelet", link: "https://www.youtube.com/watch?v=-6zXcZjSCE4", img: "https://i.ytimg.com/vi/C5WBACYnSd8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBT5ZX6qXOgwmWy5o0Xvm_gJqOyqA", isFavorite: "", recipeName: "", url: "")
        ]
    }
    
    
    
    
    
}
