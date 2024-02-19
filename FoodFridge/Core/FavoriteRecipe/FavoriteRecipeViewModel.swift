//
//  FavoriteRecipeViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation

@MainActor
class FavoriteRecipeViewModel: ObservableObject {
    @Published var listOfFavLinks: [FavoriteRecipe] = [FavoriteRecipe]()
    
    @Published var FavoriteStatus = true
    
    var userId = "test user"
    var sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
  
    func getFavoriteRecipe(userId: String, isFavorite: String) async throws {
                Task {
                    let result = try await GetFavoriteRecipe(sessionManager: sessionManager).getLinkRecipe()
                    let sortedResult = result.sorted { $0.recipeName < $1.recipeName }
                    self.listOfFavLinks = sortedResult
                }
    }
}
