//
//  GenerateRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import Foundation
class GenerateRecipe {
   
    static func getRecipe(from selectedIngredients: [String]) async throws -> [Recipe] {
        
        let ingredients = selectedIngredients

        // Create an instance of JSONEncoder
        let encoder = JSONEncoder()
        // Convert array to a dictionary with string keys
        let dict = Dictionary(uniqueKeysWithValues: zip(ingredients.indices.map(String.init), ingredients))
        
        guard let url = URL(string: AppConstant.getRecipesURLString) else {
                   throw URLError(.badURL)
               }
        // Encode the array of strings into JSON data
        do {
            let jsonData = try encoder.encode(dict)

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
                let responseData = try JSONDecoder().decode(GoogleRecipe.self, from: data)
                print("decodedRecipes = \(responseData)")
                return responseData.recipes
            }
        } catch {
            print("Error coding JSON: \(error)")
        }
            
            return Recipe.mockRecipes
        }
    
}
