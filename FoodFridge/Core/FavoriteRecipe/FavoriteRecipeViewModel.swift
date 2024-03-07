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
    @Published var isLoading: Bool = false
    
    var sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
        Task {
           try await self.getFavoriteRecipe(isFavorite: "Y")
        }
    }
  
    func getFavoriteRecipe(isFavorite: String) async throws {
       
                Task {
                    isLoading = true
                    let result = try await GetFavoriteRecipe(sessionManager: sessionManager).getLinkRecipe()
                    let sortedResult = result.sorted { $0.recipeName < $1.recipeName }
                    self.listOfFavLinks = sortedResult
                    isLoading = false
                }
        
    }
}
