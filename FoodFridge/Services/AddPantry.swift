//
//  AddPantry.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/9/24.
//

import Foundation

class AddPantry {
    
    let sessionManager: SessionManager
        
        init(sessionManager: SessionManager) {
            self.sessionManager = sessionManager
        }
    
   func addPantry(with pantryName: String) async throws {
        // Create an instance of JSONEncoder
        let encoder = JSONEncoder()
        // Create request body
        let body = Pantry(pantryName: pantryName)
        
       
       
       
        //Encode request body to JSON data
        do {
            guard let token = sessionManager.getAuthToken() else {
                throw SessionError.missingAuthToken
            }
            
            guard let localID = sessionManager.getLocalID() else {
                throw SessionError.missingLocalID
            }
            
            let urlEndpoint = ("\(AppConstant.addPantryURLString)/\(localID)")
            
            guard let url = URL(string: urlEndpoint) else {
                throw URLError(.badURL)
            }
            
            let jsonData = try encoder.encode(body)
            
            // Convert the JSON data to a string for debugging
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Encoded JSON: \(jsonString)")
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
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
