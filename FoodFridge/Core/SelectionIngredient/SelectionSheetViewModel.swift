//
//  SelectionSheetViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/17/24.
//

import Foundation

@MainActor
class SelectionSheetViewModel: ObservableObject {
    
    @Published var selections = ""
    @Published var ingredientsByType: [String: [IngredientItem]] = [:]
    @Published var itemsDict: [String : [String]] = [:]
    
    init()  {
       
            self.fetchIngredients()
            
            self.itemsDict = getItemsNameWithCategory(data: ingredientsByType)
       
    }
    
    
    func fetchIngredients()  {
        Task {
             try await ingredientsByType = GetIngredients().loadIngredients(userId: "test user")
        }
    }
    
    func getItemsNameWithCategory(data: [String: [IngredientItem]]) -> [String : [String]] {
        let ingredientNamesByType: [String: [String]] = data.mapValues { $0.map { $0.name } }
        return ingredientNamesByType
    }
    
}
