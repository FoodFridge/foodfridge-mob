//
//  AppConstant.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/27/24.
//

import Foundation
class AppConstant {
    
    static var signUpWithEmailURLString = 
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/sign_up_with_email_and_password"
    
    static var logInWithEmailURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/login_with_email_and_password"
    
    static var logInWithEmailURLString2 =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod//api/v1/LoginWithEmailAndPassword"
    
    static var refreshTokenURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/RefreshToken"
    
    static var logOutUserURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/logout"
    
    static var logOutUserURLString2 =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/Logout"
    
    static var fetchIngredientsURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/ingredient"
    
    static var getRecipesURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/GenerateRecipe"
    
    static var linkRecipeResourceURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/LinkRecipe"
    
    static var addFavoriteRecipeURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/favorite"
    
    static var getFavoriteRecipeOfuserUSLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/favorite"
    
    static var addPantryURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry/add"
    
    static var getPantryURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry"
    
    static var deletePantryURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry/delete"
    
    static var editPantryURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry/edit"
    
}
