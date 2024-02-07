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
    var addDate: String
    var item: [Pantry]
}

struct Pantry: Codable, Identifiable, Hashable {
    var id: String
    var name: String
}
extension PantryItem {
    static var mockPantryItems: [PantryItem] {
        [
            PantryItem(addDate: "Day Before Yesturday", item: [Pantry(id: "1", name: "Banana"), Pantry(id: "2", name: "Milk")] ),
            PantryItem(addDate: "Yesturday", item: [Pantry(id: "3", name: "Pork Belly"), Pantry(id: "4", name: "Kelp"), Pantry(id: "5", name: "Egg"), Pantry(id: "6", name: "Coffee")] ),
            PantryItem(addDate: "Today", item: [Pantry(id: "7", name: "Strawberry"), Pantry(id: "8", name: "Noodles")] ),
        ]
    }
}



