//
//  EdamamRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 5/3/24.
//

import Foundation
struct EdamamRecipe: Codable, Identifiable {
    
    let id: String
    let title : String
    let img : String
    let link: String
    let isFavorite: String
    let userId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case img
        case isFavorite = "favorite_status"
        case link
        case userId = "local_Id"
    }
}
    
extension EdamamRecipe {
    static var mockRecipes: [EdamamRecipe] {
            [EdamamRecipe(id: "1", title: "Pork omelet", img: "https://www.youtube.com/watch?v=J2hficUEUcE",link: "", isFavorite: "https://i.ytimg.com/vi/C5WBACYnSd8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBT5ZX6qXOgwmWy5o0Xvm_gJqOyqA", userId: "test user"),
             EdamamRecipe(id: "2", title: "Crispy Omelet", img: "https://www.youtube.com/watch?v=-6zXcZjSCE4", link: "", isFavorite: "https://i.ytimg.com/vi/C5WBACYnSd8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBT5ZX6qXOgwmWy5o0Xvm_gJqOyqA", userId: "test user")
            ]
        }
        
}
