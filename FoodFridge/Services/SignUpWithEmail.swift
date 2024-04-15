//
//  SignUpWithEmail.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import Foundation
import SwiftUI

class SignUpWithEmail {
    
    let sessionManager: SessionManager
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    
    func signUp(email:String, password: String, name: String)async throws {
        
        guard let url = URL(string: AppConstant.signUpWithEmailURLString) else { throw URLError(.badURL)}
        
        do {
            // URL request object with URL and request method
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //JSON data to be sent to the server
            let jsonData = try JSONSerialization.data(withJSONObject: ["email": email, "password": password, "name": name], options: [])
            request.httpBody = jsonData
            
            //network request
            let (_ , response) = try await URLSession.shared.data(for: request)
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw SignupError.unknown
            }
            
            print("sign up status code = \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
                
            case 200:
                //if sign up successfully
                print("Sign up successfully")
                return
                
            case 409:
                //if duplicate email
                print("Sign up duplicate email")
                //assign error to display
                throw SignupError.duplicateEmail
                
            case 400:
                //if domain doesn't accept
                print("Sign in with not accept domain")
                throw SignupError.notAcceptDomain
                
            default:
                print("Unknown error, please try again")
                //assign error to display
                throw SignupError.unknown
            }
        }
        
        catch {
            print("Sign up error = \(error.localizedDescription)")
            throw error
            
        }
        
    }
    
}


enum SignupError: Error, LocalizedError {
    case duplicateEmail
    case notAcceptDomain
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .duplicateEmail:
            return "This email is already in use"
        case .notAcceptDomain:
            return "Domain not accept for sign in, please use different email"
        case .unknown:
            return "An unknown error occurred. Please try again"
        }
    }
}
