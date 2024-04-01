//
//  TagsViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/28/23.
//

import Foundation
import SwiftUI


@MainActor
class TagsViewModel: ObservableObject {
    
    @Published var selectedTags : [String] = []
    @Published var generatedRecipes: [Recipe] = [Recipe]()
    
    @Published var ingredientsByType: [String: [IngredientItem]] = [:]
    @Published var itemsDict: [String : [String]] = [:]
    @Published var isLoading: Bool  = false
    
    var session: SessionManager
    
    init(sessionManager: SessionManager)  {
            
            self.session = sessionManager
    }
    
    func addSelectedTag(tag: String) {
        self.selectedTags.append(tag)
    }
    
    func deleteSelectedTag(tag: String)  {
        self.selectedTags.removeAll { $0 == tag }
    }
    
    func generateRecipe(from ingredients : [String]) async throws {
        isLoading = true
        var recipes: [Recipe]
        recipes = try await GenerateRecipe.getRecipe(from: self.selectedTags)
        self.generatedRecipes = recipes
        isLoading = false
    }
    
   
    func fetchIngredients() async throws {
        self.ingredientsByType = try await GetIngredients(sessionManager: session).loadIngredients()
       
    }
     
    func getItemsNameWithCategory(data: [String: [IngredientItem]])async throws -> [String : [String]] {
        let ingredientNamesByType: [String: [String]] = data.mapValues { $0.map { $0.name } }
        return ingredientNamesByType
    }
    
    
    
}

// binding class in view with @StateObject
class CreateGroup : ObservableObject {
        
    @Published var groupItemsByType: [String: [[String]]] = [:]
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    func createGroupedItemsWithType(items: [String: [String]], screenWidth: CGFloat)  {
            DispatchQueue.global(qos: .userInitiated).async {
                var groupedItemsWithType: [String: [[String]]] = [:]
                let font = UIFont.systemFont(ofSize: 17) // Assuming default UILabel font size
                let attributes: [NSAttributedString.Key: Any] = [.font: font]
                
                for (key, words) in items {
                    var width: CGFloat = 0
                    var currentGroup: [String] = []
                    
                    for word in words {
                        let size = (word as NSString).boundingRect(with: CGSize(width: self.screenWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
                        
                        let labelWidth = size.width + 40 // Adjust padding as needed
                        if (width + labelWidth + 40) < self.screenWidth {
                            width += labelWidth
                            currentGroup.append(word)
                        } else {
                            if !currentGroup.isEmpty {
                                groupedItemsWithType[key, default: []].append(currentGroup)
                            }
                            width = labelWidth
                            currentGroup = [word]
                        }
                    }
                    
                    // Append the last group if not empty
                    if !currentGroup.isEmpty {
                        groupedItemsWithType[key, default: []].append(currentGroup)
                    }
                }
                
                // Ensure UI updates are performed on the main thread
                DispatchQueue.main.async {
                    self.groupItemsByType = groupedItemsWithType
                }
            }
        }
        
    }

