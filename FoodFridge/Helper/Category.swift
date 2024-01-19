//
//  Category.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/17/24.
//

import Foundation

enum Category: String {
    
    case carb = "01"
    case protein = "02"
    case dairy = "03"
    case veggie = "04"
    case seasoning = "05"
    
    var displayName: String {
           switch self {
           case .protein:
               return "Protein"
           case .carb:
               return "Carbohydrate"
           case .dairy:
               return "Dairy Product"
           case .veggie:
               return "Fruit and Vegetable"
           case .seasoning:
               return "Seasoning"
           }
       }
    
}
