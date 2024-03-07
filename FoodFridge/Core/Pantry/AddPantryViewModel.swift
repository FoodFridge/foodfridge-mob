//
//  AddPantryViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/6/24.
//

import Foundation
class AddPantryViewModel: ObservableObject {
        @Published var searchText = ""
        @Published var suggestions: [String] = []
        
        // Sample list of ingredients
        let allIngredients = ["Apple","Apple pie", "Apple smith","Apple fuji","Apple green","Apple vinegar","Apricot","Banana","Thai namwha banana","Dried banana","Carrot", "Dates", "Eggplant", "Fig", "Grapes"]
        
        init() {
            // Update suggestions whenever searchText changes
            $searchText
                .map { text in
                    if text.isEmpty {
                        return []
                    } else {
                        return self.allIngredients.filter { $0.lowercased().contains(text.lowercased()) }
                    }
                }
                .assign(to: &$suggestions)
        }
    
    func addPantry(sessionManager: SessionManager, item: String) {
    
            Task {
                try await AddPantry(sessionManager: sessionManager).addPantry(with: item)
            }
            
    }
    
}
