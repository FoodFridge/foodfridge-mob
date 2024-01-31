//
//  FavoriteRecipeViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation
class FavoriteRecipeViewModel: ObservableObject {
    @Published var listOfFavLinks: [LinkRecipe] = [LinkRecipe]()
    
    static func getFavoriteRecipe() {
        
        
    }
}
