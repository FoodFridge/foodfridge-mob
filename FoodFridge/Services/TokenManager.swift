//
//  RequestNewToken.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/5/24.
//

import Foundation
class TokenManager: ObservableObject {
    
    // Function to decode the expiration from a JWT// not do asycn function because it's CPU-bound function
    static func decodeJWTExpiration(token: String) -> Date? {
        let segments = token.components(separatedBy: ".")
        
        guard segments.count > 1 else {
            print("Invalid JWT: Not enough segments")
            return nil
        }
        
        let payload = segments[1]
        var base64 = payload.replacingOccurrences(of: "-", with: "+")
                       .replacingOccurrences(of: "_", with: "/")
                       
        let remainder = base64.count % 4
        if remainder > 0 {
            base64 = base64.padding(toLength: base64.count + 4 - remainder, withPad: "=", startingAt: 0)
        }
        
        guard let decodedData = Data(base64Encoded: base64) else {
            print("Failed to decode base64")
            return nil
        }
        
        let jsonDecoder = JSONDecoder()
        do {
            let decodedPayload = try jsonDecoder.decode(JWTPayload.self, from: decodedData)
            return decodedPayload.exp
        } catch {
            print("Failed to decode JWT expiration: \(error)")
            return nil
        }
    }
    
    
    
    static func requestNewToken(sessionmanager: SessionManager) async throws -> String {
        guard let url = URL(string: AppConstant.refreshTokenURLString) else { throw URLError(.badURL)}
        do {
            // URL request object with URL and request method
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //JSON data to be sent to the server
            let jsonData = try? JSONSerialization.data(withJSONObject: ["refresh_token": sessionmanager.getRefreshToken()], options: [])
            request.httpBody = jsonData
            
            //network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: request token statusCode =  \(response)")
            
            //decode response data
            let jsonResponse = try JSONDecoder().decode(RefreshTokenResponse.self, from: data)
            let newToken = jsonResponse.token
            return newToken
            // Print the JSON string for debugging
            // let jsonString = String(data: data, encoding: .utf8)
            //print("JSON String: \(jsonString ?? "N/A")")
        }catch {
            print(error.localizedDescription)
        }
        return "Cannot get new token"
    }
}
