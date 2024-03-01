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
    
    
    func getPantry() async throws  -> [PantryItem] {
        
        let decoder = JSONDecoder()
        
    
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
            //print("get pantry url = \(url)")
            
            let userTimeZone  = getTimeZone()
            
            //token and userTimeZone to be sent to the server
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue(userTimeZone, forHTTPHeaderField: "User-Timezone")
            
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: statusCode =  \(response)")
            
            let jsonData = try decoder.decode(PantryResponse.self, from: data)
            
            return jsonData.data
        
            
        }catch {
            print("Error decoding JSON: \(error)")
        }
        
        return PantryItem.mockPantryItems

    }
    
    func getTimeZone() -> String {
            let timeZone = TimeZone.current.identifier
            return timeZone
        }
}
