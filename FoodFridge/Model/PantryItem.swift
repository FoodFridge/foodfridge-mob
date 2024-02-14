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
            PantryItem(date: "Day Before Yesturday", pantryInfo: [Pantry(id: "1", pantryName: "Banana"), Pantry(id: "2", pantryName: "Milk")] ),
            PantryItem(date: "Yesturday", pantryInfo: [Pantry(id: "3", pantryName: "Pork Belly"), Pantry(id: "4", pantryName: "Kelp"), Pantry(id: "5", pantryName: "Egg"), Pantry(id: "6", pantryName: "Coffee")] ),
            PantryItem(date: "Today", pantryInfo: [Pantry(id: "7", pantryName: "Strawberry"), Pantry(id: "8", pantryName: "Noodles")] ),
        ]
    }
}



