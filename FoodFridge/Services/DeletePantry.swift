//
//  DeletePantry.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/9/24.
//

import Foundation
class DeletePantry {
    
    static func delete(of pantryId: String) async throws {
        let urlEndpoint = ("\(AppConstant.deletePantryURLString)/\(pantryId)")
        
    
        do {
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
            print("delete url = \(url)")
            var request = URLRequest(url: url)
                    request.httpMethod = "DELETE"
            
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: statusCode =  \(response)")
            
            
        }catch {
            print("Error deleting: \(error)")
        }
    }
}
