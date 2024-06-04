//
//  EdamamRecipeRequestBody.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 5/3/24.
//

import Foundation
struct EdamamRecipeRequestBody: Codable {
    let userId: String
    let ingredients: [String]
}
