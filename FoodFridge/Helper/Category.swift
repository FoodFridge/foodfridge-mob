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
    case seafood = "04"
    case veggie = "05"
    case fruit = "06"
    case seasoning = "07"
    case pantry = "08"
    
    
    
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
           case .pantry:
               return "Pantry"
            
           }
       }
    
}
