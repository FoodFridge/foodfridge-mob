//
//  FavoriteRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation
struct FavoriteLinkRecipe: Codable {
    var data : [LinkRecipe]
}

struct FavoriteRecipeResponse: Codable  {
    var data : [FavoriteRecipe]
}

struct FavoriteRecipe: Codable {
    var recipeName : String
    var recipeLink  : [RecipeLink]
}

struct RecipeLink: Codable, Identifiable {
    
    var id: String
    var img: String
    var title: String
    var url:String
    var isFavorite: String
    var userId: String
    
    enum CodingKeys: String, CodingKey {
        case id = "favId"
        case img
        case title
        case url
        case isFavorite
        case userId
    }
}


struct LinkRecipe2: Codable, Identifiable {
    var id: String
    var img: String
    var title: String
    var recipeName: String
    var url: String
    var isFavorite: String
    
    enum CodingKeys: String, CodingKey {
        case id = "favId"
        case img
        case title
        case recipeName
        case url
        case isFavorite
    }
    
}

extension FavoriteLinkRecipe {
    static var mockFavoriteRecipes: [LinkRecipe] {
        [LinkRecipe(id: "1", title: "Noodle Boat Ayuttaya", img: "", isFavorite: "Y", recipeName: "Noodles", url: "", userId: "test user"),
         LinkRecipe(id: "2", title: "Fired rice", img: "", isFavorite: "Y", recipeName: "Noodles", url: "", userId: "tes user")]
    }
}
