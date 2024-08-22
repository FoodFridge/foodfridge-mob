//
//  AddFavoriteRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation
class UpdateFavoriteRecipe {
    static func updateFavorite(linkId: String, isFavorite: Bool) async throws {
        // Create an instance of JSONEncoder
        let encoder = JSONEncoder()
        let urlEndpoint = AppConstant.addFavoriteRecipeURLString
        // Create request body
        let body = FavoriteRecipeRequestBody(favId: linkId, isFavorite: isFavorite ? "Y" : "N")
        
        guard let url = URL(string: urlEndpoint) else {
                   throw URLError(.badURL)
               }
        //Encode request body to JSON data
        do {
            let jsonData = try encoder.encode(body)
            // Convert the JSON data to a string for debugging
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Encoded JSON: \(jsonString)")
                
                //make URLRequest and header
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                //make request with URL session
                let (data, response) = try await URLSession.shared.data(for: request)
                
                // Handle the response
                guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
                print("DEBUG: statusCode =  \(response)")
                
                if let responseText = String(data: data, encoding: .utf8) {
                 print("update fav  response = \(responseText)")
                    
                }
                
            }
            
        }
        catch {
            print("Error encoding JSON \(error.localizedDescription)")
        }
        
        
    }
}
