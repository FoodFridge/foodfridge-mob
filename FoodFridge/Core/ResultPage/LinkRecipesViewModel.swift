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
    var sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }

    func getLinkRecipes(recipeName: String ) async throws -> [LinkRecipe] {
        
       listOfgoogleLinks = try await LinkRecipeResource(sessionManager: sessionManager).getLinkRecipe(recipeName: recipeName)
        
        return listOfgoogleLinks
    }
    
   
    
}
