//
//  GetPantry.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/8/24.
//

import Foundation
class GetPantry {
    
    var pantryItems:[PantryItem] = [PantryItem]()
    
    static func getPantry(of userId: String = "test user") async throws  -> [PantryItem] {
        let urlEndpoint = ("\(AppConstant.getPantryURLString)/\(userId)")
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
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
            
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
