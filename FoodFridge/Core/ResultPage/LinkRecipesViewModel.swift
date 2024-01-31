//
//  ResultViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import Foundation

@MainActor
class LinkRecipesViewModel: ObservableObject {
    
    @Published var listOfgoogleLinks: [LinkRecipe] = [LinkRecipe]()

    func getLinkRecipes(fromUserId: String, recipeName: String ) async throws -> [LinkRecipe] {
        
       listOfgoogleLinks = try await LinkRecipeResource.getLinkRecipe(userId: fromUserId, recipeName: recipeName)
        
        return listOfgoogleLinks
    }
    
}
