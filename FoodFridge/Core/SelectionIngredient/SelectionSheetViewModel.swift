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
    
    var session: SessionManager
    
    init(sessionManager: SessionManager)  {
            
            self.session = sessionManager
    }
    
    
    func fetchIngredients() async throws -> [String: [IngredientItem]] {
        self.ingredientsByType = try await GetIngredients(sessionManager: session).loadIngredients()
        return self.ingredientsByType
    }
    
    func getItemsNameWithCategory(data: [String: [IngredientItem]]) async throws  -> [String : [String]] {
        let ingredientNamesByType: [String: [String]] = data.mapValues { $0.map { $0.name } }
        return ingredientNamesByType
    }
    
}
