//
//  IngredientItem.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/16/24.
//

import Foundation

struct IngredientData: Codable {
    var data: [IngredientItem]
}

struct IngredientItem: Codable, Identifiable, Hashable {
    let id: String
    var name: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
               case id = "ingredient_id"
               case name = "ingredient_name"
               case type = "ingredient_type_code"
    }
        
}

extension IngredientItem {
    static var mockItems: [IngredientItem] {
        [ IngredientItem(id: "01", name: "Strawberry", type: "01"),
          IngredientItem(id: "02", name: "Pork belly", type: "02"),
          IngredientItem(id: "03", name: "Kelp", type: "03"),
          IngredientItem(id: "04", name: "Cauliflower", type: "04"),
          IngredientItem(id: "05", name: "Egg", type: "05")
        ]
    }
}

 
