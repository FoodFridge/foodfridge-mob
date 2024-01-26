//
//  GoogleSearchRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/26/24.
//

import Foundation
struct GoogleSearchRecipe: Codable, Hashable {
    let title: String
    let link: String
    let img: String
}

extension GoogleSearchRecipe {
    static var mockGoogleSearchRecipes : [GoogleSearchRecipe] {
        [ GoogleSearchRecipe(title:"Salmon With Ginger Glaze", link: <#String#>, img: "https://spoonacular.com/recipeImages/86929-312x231.jpg"),
          GoogleSearchRecipe(title:"Salmon Steak in Caramel Sauce (Vietnamese Ca Kho)", img: "https://spoonacular.com/recipeImages/87802-312x231.jpg"),
          GoogleSearchRecipe(title:"Ginger Soy Salmon – 5 Points", img: "https://spoonacular.com/recipeImages/548227-312x231.jpg"),
          GoogleSearchRecipe(title: "Teriyaki Salmon", img: "https://spoonacular.com/recipeImages/86986-312x231.jpg"),
          GoogleSearchRecipe(title: "Brown Sugar and Ginger Glazed Salmon", img: "https://spoonacular.com/recipeImages/86964-312x231.jpg")
        ]
        
    }
    
}
