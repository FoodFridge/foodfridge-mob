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
    case seafood = "07"
    case fruit = "08"
    
    var displayName: String {
           switch self {
           case .protein:
               return "Meat"
           case .carb:
               return "Carbohydrate"
           case .dairy:
               return "Dairy Product"
           case .veggie:
               return "Vegetable"
           case .seasoning:
               return "Seasoning"
           case .seafood:
               return "Seafood"
           case .fruit:
               return "Fruit"
            
           }
       }
    
}
