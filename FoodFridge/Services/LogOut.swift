//
//  LogOut.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/16/24.
//

import Foundation
class LogOut: ObservableObject {
    
   static func logUserOut() async throws -> Bool {
           
           guard let url = URL(string: AppConstant.logOutUserURLString) else { throw URLError(.badURL)}
           
           do {
               // URL request object with URL and request method
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               /*
               //JSON data to be sent to the server
               let jsonData = try? JSONSerialization.data(withJSONObject: ["email": email, "password": password, "name": name], options: [])
               request.httpBody = jsonData
                */
               
               //network request
               let (_, response) = try await URLSession.shared.data(for: request)
               
               guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
               print("DEBUG: statusCode =  \(response)")
               print("log out response = \(response.description)")
           
             //  let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
               
               //if sign up successfully
               print("log out successfully")
               
               return true
               
               
           }catch {
               print("Error: \(error.localizedDescription)")
           }
            
      
            return false
       }
    
    
}
