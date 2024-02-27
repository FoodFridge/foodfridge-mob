//
//  Category.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/17/24.
//

import Foundation

enum Category: String, CaseIterable {
    
    case pantry = "01"
    case protein = "02"
    case seafood = "03"
    case dairy = "04"
    case sauces = "05"
    case cereal = "06"
    case carb = "07"
    case veggie = "08"
    case fruit = "09"
    case seasoning = "10"
    case sugar = "11"
    case others = "12"
    
    
    
    var displayName: String {
           switch self {
           case .protein:
               return "Meat"
           case .carb:
               return "Carb"
           case .dairy:
               return "Dairy"
           case .veggie:
               return "Veggie"
           case .seasoning:
               return "Spices"
           case .seafood:
               return "Seafood"
           case .fruit:
               return "Fruit"
           case .pantry:
               return "My pantry"
           case .cereal:
               return "Nuts"
           case .others:
               return "Others"
           case .sauces:
               return "Sauce"
           case .sugar:
               return "Sugar"
           }
       }
    
}
