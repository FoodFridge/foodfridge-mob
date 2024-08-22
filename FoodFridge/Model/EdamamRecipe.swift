//
//  EdamamRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 5/3/24.
//

import Foundation
struct EdamamRecipe: Codable, Identifiable, Hashable {
    
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
        case userId = "local_id"
    }
    
}
    
extension EdamamRecipe {
    static var mockRecipes: [EdamamRecipe] {
            [
            ]
        }
        
}
