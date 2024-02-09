//
//  AppConstant.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/27/24.
//

import Foundation
class AppConstant {
    static var fetchIngredientsURLString = "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/ingredient"
    static var getRecipesURLString =
    "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/GenerateRecipe"
    static var linkRecipeResourceURLString = "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/LinkRecipe"
    static var addFavoriteRecipeURLString = "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/favorite"
    static var getFavoriteRecipeOfuserUSLString = "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/favorite"
    static var getPantryURLString = "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry"
}
