//
//  EditPantry.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/10/24.
//

import Foundation
class EditPantry {
    
    static func edit(itemID: String, to newItem: String) async throws {
      

        do {
            let urlEndpoint = ("\(AppConstant.editPantryURLString)/\(itemID)")
            print("edit pantry url = \(urlEndpoint)")
            
            guard let url = URL(string: urlEndpoint) else {
                throw URLError(.badURL)
            }
            
            //JSON data to be sent to the server
            let jsonData = try? JSONSerialization.data(withJSONObject: ["pantryName": newItem], options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
            // Make the request using URLSession
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else {  throw URLError(.badServerResponse)  }
            print("DEBUG: statusCode =  \(response)")
        
        }catch {
            print("edit pantry error = \(error.localizedDescription)")
            
        }
        
        
    }
    
    
}
