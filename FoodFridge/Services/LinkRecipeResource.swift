//
//  SearchGoogleRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/30/24.
//

import Foundation
class LinkRecipeResource {
    
    static func getLinkRecipe(userId: String , recipeName: String) async throws -> [LinkRecipe] {
        // Create an instance of JSONEncoder
        let encoder = JSONEncoder()
        // Create request body
        let body = LinkRecipeRequestBody(userId: userId, recipeName: recipeName)
        
        guard let url = URL(string: AppConstant.linkRecipeResourceURLString) else {
                   throw URLError(.badURL)
               }
        //Encode request body to JSON data
        do {
            let jsonData = try encoder.encode(body)

            // Convert the JSON data to a string for debugging
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Encoded JSON: \(jsonString)")

                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                // Make the request using URLSession
                let (data, response) = try await URLSession.shared.data(for: request)
               
                
                guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
                print("DEBUG: statusCode =  \(response)")

                // Handle the response
                if let responseText = String(data: data, encoding: .utf8) {
                 print("response = \(responseText)")
                }
                // Decode resonse data to LinkRecipe
                let responseData = try JSONDecoder().decode(LinkeRecipeResponseData.self, from: data)
                print("LinkRecipe = \(responseData.data)")
                return responseData.data
            }
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            //detailed error info:
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(let key, let context):
                    print("Type mismatch for key \(key), \(context.debugDescription)")
                case .valueNotFound(let key, let context):
                    print("Value not found for key \(key), \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key not found \(key), \(context.debugDescription)")
                case .dataCorrupted(let context):
                    print("Data corrupted, \(context.debugDescription)")
                @unknown default:
                    print("Unknown error")
                }
            }
        }
        
        return LinkRecipe.mockLinkRecipes
    }
    
    
}
