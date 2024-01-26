//
//  Recipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import Foundation

struct Recipe: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let imageURL: String
}

extension Recipe {
    static var mockRecipes: [Recipe] {
        [ Recipe(id: 1, title:"Salmon With Ginger Glaze", imageURL: "https://spoonacular.com/recipeImages/86929-312x231.jpg"),
          Recipe(id: 2, title:"Salmon Steak in Caramel Sauce (Vietnamese Ca Kho)", imageURL: "https://spoonacular.com/recipeImages/87802-312x231.jpg"),
          Recipe(id: 3, title:"Ginger Soy Salmon – 5 Points", imageURL: "https://spoonacular.com/recipeImages/548227-312x231.jpg"),
          Recipe(id: 4, title: "Teriyaki Salmon", imageURL: "https://spoonacular.com/recipeImages/86986-312x231.jpg"),
          Recipe(id: 5, title: "Brown Sugar and Ginger Glazed Salmon", imageURL: "https://spoonacular.com/recipeImages/86964-312x231.jpg")
        ]
    }
}
