//
//  GenerateRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import Foundation
class GenerateRecipe {
    
    let sessionManager: SessionManager
        
        init(sessionManager: SessionManager) {
            self.sessionManager = sessionManager
        }
    
   
    func getRecipe(from selectedIngredients: [String]) async throws -> [EdamamRecipe] {
        
        let ingredients = selectedIngredients

        // Convert array to a dictionary with string keys
        let dict = Dictionary(uniqueKeysWithValues: zip(ingredients.indices.map(String.init), ingredients))
        
        guard let url = URL(string: AppConstant.generateRecipWithEdamam) else {
                   throw URLError(.badURL)
               }
        // Encode the array of strings into JSON data
        do {
            
            let localID = sessionManager.getLocalID()
            print("generate recipe user id = \(String(describing: localID))")
            
            let jsonData = try JSONSerialization.data(withJSONObject: ["local_id": localID ?? "", "ingredient": dict], options: [])
           
            // Convert the JSON data to a string for debugging
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Encoded JSON: \(jsonString)")

                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                // Make the request using URLSession
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                // Handle the response
                if let responseText = String(data: data, encoding: .utf8) {
                 print("response = \(responseText)")
                }
                // Decode data to SpoonRecipe
                let responseData = try JSONDecoder().decode([EdamamRecipe].self, from: data)
                print("Edaman Recipes = \(responseData)")
                return responseData
            }
        } catch {
            print("Error coding JSON: \(error)")
        }
            
            return EdamamRecipe.mockRecipes
        }
    
}
