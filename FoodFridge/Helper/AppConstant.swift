//
//  AppConstant.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/27/24.
//

import Foundation
class AppConstant {
    
    static var signUpWithEmailURLString = 
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/SignupWithEmailAndPassword"
    
    static var logInWithEmailURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/login_with_email_and_password"
    
    static var logInWithEmailURLString2 =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/LoginWithEmailAndPassword"
    
    static var resetPasswordURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/ResetPassword"
    
    static var authWithAppURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/AuthWithApp"
    
    static var refreshTokenURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/RefreshToken"
    
    static var logOutUserURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/logout"
    
    static var logOutUserURLString2 =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/Logout"
    
    static var fetchIngredientsURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/ingredient"
    
    static var fetchPantryIngredientsURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/SearchIngredient"
    
    static var getRecipesURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/GenerateRecipeWithGoogle"
    
    static var linkRecipeResourceURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/Link"
    
    static var addFavoriteRecipeURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/favoriteRecipe"
    
    static var getFavoriteRecipeOfuserUSLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/favoriteRecipe"
    
    static var addPantryURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry/add"
    
    static var getPantryURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry"
    
    static var deletePantryURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry/delete"
    
    static var editPantryURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/pantry/edit"
    
    static let privacyPolicyLink =
        URL(string: "https://sites.google.com/view/foodfridge-privacy-policy/home")
    
    static let termOfUseLink =
        URL(string: "https://sites.google.com/view/foodfridge-eula/home")
    
    static let appReviewLink =
        URL(string: "https://apps.apple.com/app/id6476799564?action=write-review")
    
    static let deleteUserAccountURLString =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/deleteUserAccount"
    
    static let generateRecipWithEdamam =
        "https://3vrjipny8a.execute-api.us-east-1.amazonaws.com/prod/api/v1/GenerateRecipeWithEdamam"
    
    
}
