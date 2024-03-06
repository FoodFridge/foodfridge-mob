//
//  IngredientItem.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/16/24.
//

import Foundation

struct IngredientData: Decodable {
    let status: String
    let message: String
    let data: [IngredientItem]
}

struct IngredientItem: Decodable, Identifiable {
    let id: String
    var userId: String
    var name: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
               case id = "doc_id"
               case name = "ingredient_name"
               case userId = "user_id"
               case type = "ingredient_type_code"
              
    }
        
}

extension IngredientItem {
    static var mockItems: [IngredientItem] {
        
        
        [ IngredientItem(id: "01", userId: "test user", name: "Strawberry", type: "01"),
          IngredientItem(id: "02", userId: "test user", name: "Pork belly", type: "02"),
          IngredientItem(id: "03", userId: "test user", name: "Kelp", type: "03"),
          IngredientItem(id: "04", userId: "test user", name: "Cauliflower", type: "04"),
          IngredientItem(id: "05", userId: "test user", name: "Egg", type: "05")
        ]
         
    }
}

 
