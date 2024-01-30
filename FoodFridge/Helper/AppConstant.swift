//
//  AppConstant.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/27/24.
//

import Foundation
class AppConstant {
    static var fetchIngredientsURLStinng = "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/ingredient"
    static var getRecipesURLString =
    "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/GenerateRecipe"
    static var getGoogleRecipesURLString = "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/search/<string:recipeName>"
}
