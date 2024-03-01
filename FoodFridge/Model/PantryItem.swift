//
//  PantryItem.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/13/24.
//

import Foundation

struct PantryResponse: Codable {
    var data: [PantryItem]
}

struct PantryItem: Codable, Hashable {
    //need to name constant "id" to conform to identifiable protocal
    var date: String
    var pantryInfo: [Pantry]
}

struct Pantry: Codable, Identifiable, Hashable {
    var id: String?
    var pantryName: String
    
    enum CodingKeys: String, CodingKey {
               case id = "doc_id"
               case pantryName
    }
}
extension PantryItem {
    static var mockPantryItems: [PantryItem] {
        [
            
        ]
    }
}



