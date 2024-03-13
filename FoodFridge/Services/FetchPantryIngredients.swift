//
//  FetchPantryIngredients.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/13/24.
//

import Foundation
class FetchPantryIngredients {
    func quaryIngredients(text: String) async throws -> [String] {
        
        let urlEndpoint = ("\(AppConstant.fetchPantryIngredientsURLString)")
        let decoder = JSONDecoder()
        
        do {
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
            
            let requestBody = try? JSONSerialization.data(withJSONObject: ["ingredient": text], options: [])
            
            var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.httpBody = requestBody
    
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
                   
            guard(response as? HTTPURLResponse)?.statusCode == 200 else {
                print("DeBug: cannot fetch pantry ingredients = \(response)")
                throw FetchError.serverError }
                print("DEBUG: pantry ingredient search statusCode =  \(response)")
            
            let jsonData = try decoder.decode([String].self, from: data)
            return jsonData
            
        }catch {
            print("error search completion = \(error.localizedDescription)")
        }
        
        return [""]
    }
}
