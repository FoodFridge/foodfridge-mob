//
//  AddFavoriteRecipeResonseData.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation
struct AddFavoriteResponse: Codable {
    var success: String
    var documentId: String

    enum CodingKeys: String, CodingKey {
        case success
        case documentId = "document_id"
    }
}
