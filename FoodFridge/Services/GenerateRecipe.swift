//
//  GenerateRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import Foundation
class generateRecipe {
    var returnRecipes: [Recipe]
    
    init(returnRecipes: [Recipe]) {
        self.returnRecipes = getRecipe()
        
        func getRecipe() -> [Recipe] {
            
            
            
            
            return Recipe.mockRecipes
        }
    }
}
