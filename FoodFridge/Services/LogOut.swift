//
//  LogOut.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/16/24.
//

import Foundation
class LogOut: ObservableObject {
    
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
        
    
   func logUserOut() async throws -> Bool {
           
           guard let url = URL(string: AppConstant.logOutUserURLString) else { throw URLError(.badURL)}
           
           do {
               guard let token = sessionManager.getAuthToken() else {
                   throw SessionError.missingAuthToken
               }
               // URL request object with URL and request method
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.setValue("\(token)", forHTTPHeaderField: "Authorization")
            
               //network request
               let (_, response) = try await URLSession.shared.data(for: request)
               
               guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
               print("DEBUG: statusCode =  \(response)")
               print("log out response = \(response.description)")
           
               //if sign up successfully
               print("log out successfully")
               
               return true
               
               
           }catch {
               print("Error: \(error.localizedDescription)")
           }
            
      
            return false
       }
    
    
}
