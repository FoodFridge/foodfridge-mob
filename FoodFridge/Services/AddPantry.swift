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
    
   func addPantry(with pantryName: String) async throws -> Int {
       
       var addPantryResponseCode: Int = 0
        // Create an instance of JSONEncoder
        let encoder = JSONEncoder()
        // Create request body
        let body = Pantry(pantryName: pantryName)
        
        //Encode request body to JSON data
        do {
            /*
            guard let token = sessionManager.getAuthToken() else {
                throw SessionError.missingAuthToken
            }
             */
            
            guard let localID = sessionManager.getLocalID() else {
                throw SessionError.missingLocalID
            }
            
            let urlEndpoint = ("\(AppConstant.addPantryURLString)/\(localID)")
            print("add pantry url = \(urlEndpoint)")
            
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
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                //request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                // Make the request using URLSession
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        addPantryResponseCode = 200
                    case 409:
                        addPantryResponseCode = 400
                    default:
                        addPantryResponseCode = httpResponse.statusCode
                    }
                }
                // Handle the response
                if let responseText = String(data: data, encoding: .utf8) {
                 print("response = \(responseText)")
                }
            }
            
            return addPantryResponseCode
            
            
        }catch {
            print("add pantry error = \(error.localizedDescription)")
        }
       
       return addPantryResponseCode
     
    }
   
}
