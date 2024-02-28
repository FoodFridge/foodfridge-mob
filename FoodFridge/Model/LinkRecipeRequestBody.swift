//
//  LinkRecipeRequestBody.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/30/24.
//

import Foundation
struct LinkRecipeRequestBody: Codable {
    let localId: String
    let recipeName: String
}
