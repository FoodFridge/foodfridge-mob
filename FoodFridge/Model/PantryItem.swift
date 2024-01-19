//
//  PantryItem.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/13/24.
//

import Foundation

struct PantryItem: Codable, Identifiable, Hashable {
    //need to name constant "id" to conform to identifiable protocal
    let id: Int
    var itemName: String
    var addDate: Date
}
extension PantryItem {
    static var mockPantryItem: [PantryItem] {
        [ PantryItem(id: 1, itemName: "Strawberry", addDate: Date()),
          PantryItem(id: 2, itemName: "Pork belly", addDate: Date()),
          PantryItem(id: 3, itemName: "Kelp", addDate: Date()),
          PantryItem(id: 4, itemName: "Cauliflower", addDate: Date()),
          PantryItem(id: 5, itemName: "Egg", addDate: Date())
        ]
    }
}



