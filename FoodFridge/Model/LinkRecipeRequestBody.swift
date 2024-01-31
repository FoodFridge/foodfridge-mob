//
//  LinkRecipeRequestBody.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/30/24.
//

import Foundation
struct LinkRecipeRequestBody: Codable {
    let userId: String
    let recipeName: String
}
