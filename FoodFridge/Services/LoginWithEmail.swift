//
//  LoginWithEmail.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import Foundation
class LoginWithEmailService: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
 
    func login(email:String, password: String) async throws -> LogInResponseData.LogInData {
           
           guard let url = URL(string: AppConstant.logInWithEmailURLString) else { throw URLError(.badURL)}
           
           do {
               // URL request object with URL and request method
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               
               //JSON data to be sent to the server
               let jsonData = try? JSONSerialization.data(withJSONObject: ["email": email, "password": password], options: [])
               request.httpBody = jsonData
               
               //network request
               let (data, response) = try await URLSession.shared.data(for: request)
               
               guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
               print("DEBUG: login statusCode =  \(response)")
               
               //decode response data
               let jsonResponse = try JSONDecoder().decode(LogInResponseData.self, from: data)
               
               // Print the JSON string for debugging
               let jsonString = String(data: data, encoding: .utf8)
               print("JSON String: \(jsonString ?? "N/A")")
               
               //if successfully
               print("log in successfully")
               
               return jsonResponse.data
               
               
           }catch {
               print("Log in Error: \(error.localizedDescription)")
           }
            
        return LogInResponseData.MOCKdata.data
        
       }
       
   }

