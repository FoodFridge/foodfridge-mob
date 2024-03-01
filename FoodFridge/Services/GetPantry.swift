//
//  GetPantry.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/8/24.
//

import Foundation
import SwiftUI

class GetPantry {
    
    var pantryItems:[PantryItem] = [PantryItem]()
    
    let sessionManager: SessionManager
        
        init(sessionManager: SessionManager) {
            self.sessionManager = sessionManager
        }
    
    
    func getPantry(of userTimeZone: String = "America/New_York") async throws  -> [PantryItem] {
        
        let decoder = JSONDecoder()
        
        /*
        guard let url = Bundle.main.url(forResource: "Pantry", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("JSON file was not found")
            return PantryItem.mockPantryItems
        }
        
        // Print the JSON string for debugging
        let jsonString = String(data: data, encoding: .utf8)
        print("pantry JSON String: \(jsonString ?? "N/A")")
        */
        
        
        do {
           
            guard let token = sessionManager.getAuthToken() else {
                throw SessionError.missingAuthToken
            }
            
            
            guard let localID = sessionManager.getLocalID() else {
                throw SessionError.missingLocalID
            }
            
            let urlEndpoint = ("\(AppConstant.getPantryURLString)/\(localID)")
            
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
            
            
            let requestBody = try? JSONSerialization.data(withJSONObject: ["User-Timezone": userTimeZone ], options: [])
            
            //JSON data to be sent to the server
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.httpBody = requestBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: statusCode =  \(response)")
            
            let jsonData = try decoder.decode(PantryResponse.self, from: data)
            
            return jsonData.data
        
            
        }catch {
            print("Error decoding JSON: \(error)")
        }
        
        return PantryItem.mockPantryItems

    }
    
}
