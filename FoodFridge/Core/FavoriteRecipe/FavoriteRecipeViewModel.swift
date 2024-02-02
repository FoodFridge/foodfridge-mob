//
//  FavoriteRecipeViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation

@MainActor
class FavoriteRecipeViewModel: ObservableObject {
    @Published var listOfFavLinks: [LinkRecipe] = [LinkRecipe]()
    var userId = "test user"
  
    func getFavoriteRecipe(userId: String, isFavorite: String) async throws {
                Task {
                    let result = try await GetFavoriteRecipe.getLinkRecipe(userId: userId, isFavorite: "Y")
                    self.listOfFavLinks = result
                }
    }
}
