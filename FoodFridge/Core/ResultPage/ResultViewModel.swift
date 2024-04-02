//
//  ResultViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 4/2/24.
//

import Foundation

@MainActor
class ResultViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [Recipe]()
    @Published var isLoading: Bool = false
    
    init(ingredients: [String]) {
        generatedRecipes(from: ingredients)
    }
    
    func generatedRecipes(from ingredients: [String]) {
        Task {
            self.isLoading = true
            self.recipes = try await GenerateRecipe.getRecipe(from: ingredients)
            self.isLoading = false
            
        }
    }
    
}
