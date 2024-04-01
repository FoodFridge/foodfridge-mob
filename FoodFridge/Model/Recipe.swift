//
//  Recipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import Foundation

struct GoogleRecipe: Codable {
    let success: Bool
    let recipes: [Recipe]
}


struct Recipe: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let img: String
}

extension Recipe {
    static var mockRecipes: [Recipe] {
        [ Recipe(id: "1", title: "Salmon With Ginger Glaze", img: "https://spoonacular.com/recipeImages/86929-312x231.jpg"),
          Recipe(id: "2", title: "Salmon Steak in Caramel Sauce (Vietnamese Ca Kho)", img: "https://spoonacular.com/recipeImages/87802-312x231.jpg"),
          Recipe(id: "3", title: "Ginger Soy Salmon – 5 Points", img: "https://spoonacular.com/recipeImages/548227-312x231.jpg"),
          Recipe(id: "4", title: "Teriyaki Salmon", img: "https://spoonacular.com/recipeImages/86986-312x231.jpg"),
          Recipe(id: "5", title: "Brown Sugar and Ginger Glazed Salmon", img: "https://spoonacular.com/recipeImages/86964-312x231.jpg")
        ]
    }
}
