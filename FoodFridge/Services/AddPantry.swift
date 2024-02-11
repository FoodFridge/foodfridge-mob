//
//  AddPantry.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/9/24.
//

import Foundation
class AddPantry {
    static func addPantry(with pantryName: String, by userId: String) async throws {
        // Create an instance of JSONEncoder
        let encoder = JSONEncoder()
        // Create request body
        let body = Pantry(pantryName: pantryName)
        
        let urlEndpoint = ("\(AppConstant.addPantryURLString)/\(userId)")
        
        guard let url = URL(string: urlEndpoint) else {
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
                let (_, response) = try await URLSession.shared.data(for: request)
                
                guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
                print("DEBUG: statusCode =  \(response)")
                
            }
            
        }catch {
            print(error.localizedDescription)
        }
    
    }
}
