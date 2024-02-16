//
//  SignUpWithEmail.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import Foundation
import SwiftUI

class SignUpWithEmail {
    /*
    
        var navigationController: NavigationViewModel

        init(navigationController: NavigationViewModel) {
            self.navigationController = navigationController
        }
     */
    
     func signUp(email:String, password: String, name: String)async throws -> Bool {
        
        guard let url = URL(string: AppConstant.signUpWithEmailURLString) else { throw URLError(.badURL)}
        
        do {
            // URL request object with URL and request method
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //JSON data to be sent to the server
            let jsonData = try? JSONSerialization.data(withJSONObject: ["email": email, "password": password, "name": name], options: [])
            request.httpBody = jsonData
            
            //network request
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: statusCode =  \(response)")
            
        
          //  let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
            
            //if sign up successfully
            print("Sign up successfully")
            
            return true
            
            
        }catch {
            print("Error: Unable to parse JSON response")
        }
         
   
         return false
    }
    
}

enum Destination: Hashable {
    case landingPage
    case logInPage
}
