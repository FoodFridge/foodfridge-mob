//
//  TagsViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/28/23.
//

import Foundation

@MainActor
class TagsViewModel: ObservableObject {
    
    @Published var selectedTags = [String]()
    @Published var generatedRecipes: [Recipe] = [Recipe]()
    
    func addSelectedTag(tag: String) {
        self.selectedTags.append(tag)
    }
    
    func deleteSelectedTag(tag: String)  {
        self.selectedTags.removeAll { $0 == tag }
    }
    
    func generateRecipe(ingredients : [String]) async throws {
        let ingredients = ingredients
        var recipes: [Recipe]
        recipes = try await GenerateRecipe.getRecipe(Ingredients: ingredients)
        self.generatedRecipes = recipes
    }
    
}
