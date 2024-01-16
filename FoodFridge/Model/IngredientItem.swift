//
//  IngredientItem.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/15/24.
//

import Foundation


struct IngredientItem: Codable, Identifiable, Hashable {
    let id: String
    var name: String
    var type: String
}

enum CodingKeys: String, CodingKey {
           case id = "ingredient_id"
           case name = "ingredient_name"
           case type = "ingredient_type_code"
}
    


