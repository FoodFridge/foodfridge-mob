//
//  ResetPassword.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 4/2/24.
//

import Foundation
class ResetPassword {
    
    static func requestResetEmail(email: String)async throws -> Int {
        guard let url = URL(string: AppConstant.resetPasswordURLString) else { throw URLError(.badURL)}
        do {
            // URL request object with URL and request method
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //JSON data to be sent to the server
            let jsonData = try JSONSerialization.data(withJSONObject: ["email": email], options: [])
            request.httpBody = jsonData
            
            //network request
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw LogInError.unknown
            }
            
            //check resonse code
            switch httpResponse.statusCode {
            case 200:
                print("sent email to reset password")
                return 200
            case 404:
                print("not found email in app's database")
                return 404
            default:
                print("Server error")
                return 500
            }
        }
    }
    
}

