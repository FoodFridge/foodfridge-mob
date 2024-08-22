//
//  ResultViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 4/2/24.
//

import Foundation

@MainActor
class ResultViewModel: ObservableObject {
    @Published var recipes: [EdamamRecipe] = [EdamamRecipe]()
    @Published var isLoading: Bool = false
    
    init(ingredients: [String], sessionManager: SessionManager) {
        generateRecipes(from: ingredients, sessionManager: sessionManager)
    }
    
    func generateRecipes(from ingredients: [String], sessionManager: SessionManager) {
        Task {
            self.isLoading = true
            self.recipes = try await GenerateRecipe(sessionManager: sessionManager).getRecipe(from: ingredients)
            self.isLoading = false
            
        }
    }
    
}
