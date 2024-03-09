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
    
    // Verify token expired
    static func isTokenExpired(expiryDateUnix: TimeInterval, userTimeZoneIdentifier: String) -> Bool {
            // Convert Unix timestamp to Date object
            let expiryDate = Date(timeIntervalSince1970: expiryDateUnix)
            print("exp date = \(expiryDate)")
            // Specify the user's time zone
            let userTimeZone = TimeZone(identifier: userTimeZoneIdentifier)!
            // Use the user's time zone in the calendar
            var calendar = Calendar.current
            calendar.timeZone = userTimeZone
            // Get the current date and time, adjusted for the user's time zone
            let currentDate = Date()
            print("user current date = \(currentDate)")
            // Compare the current date with the expiry date
            if currentDate > expiryDate {
                print("token expired")
            }else {
                print("token still valid")
            }
            return currentDate > expiryDate
        }
    
    
    
    static func requestNewToken(sessionmanager: SessionManager) async throws -> RefreshTokenResponse? {
        guard let url = URL(string: AppConstant.refreshTokenURLString) else { throw URLError(.badURL)}
        do {
            // URL request object with URL and request method
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let refreshToken = sessionmanager.getRefreshToken() else {
                throw TokenError.tokenNotFound
            }
            print("request with refreshtoken = \(String(describing: refreshToken))")
            //JSON data to be sent to the server
            let jsonData = try? JSONSerialization.data(withJSONObject: ["refresh_token": refreshToken], options: [])
            request.httpBody = jsonData
            
            //network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: request token statusCode =  \(response)")
            
            //decode response data
            let jsonResponse = try JSONDecoder().decode(RefreshTokenResponse.self, from: data)
            let newToken = jsonResponse.token
            print("got new token = \(newToken)")
            let newExp = jsonResponse.expTime
            print ("got new exp = \(newExp)")
            return jsonResponse
            // Print the JSON string for debugging
            // let jsonString = String(data: data, encoding: .utf8)
            //print("JSON String: \(jsonString ?? "N/A")")
        }catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    static func verifyTokenAndRequestNewToken(expTime: TimeInterval, userTimeZone: String, sessionManager: SessionManager) async throws -> String? {
        
        
        //verify if token has expired?
        if self.isTokenExpired(expiryDateUnix: expTime, userTimeZoneIdentifier: userTimeZone) {
            print("Token expired!!")
            //if token expired will remove expired token
            sessionManager.removeToken()
            print("Removed token")
            
            do {
                // make a request
                guard let response = try await self.requestNewToken(sessionmanager: sessionManager) else {
                    print("cannot get response from request new token")
                    throw TokenError.tokenNotFound
                }
                // save new exp in session
                sessionManager.saveExpTime(exp: response.expTime)
                print("new exp = \(response.expTime)")
                //save new token in session
                sessionManager.saveAuthToken(token: response.token)
                print("new token = \(response.token)")
                //get new token
                let newToken = sessionManager.getAuthToken()
                print("return new token = \(String(describing: newToken))")
                return newToken
                
            } catch{
                print("Error requesting new token: \(error)")
            }
        }
        //if token hasn't expired return nil
        return nil
    }
}

enum TokenError: Error {
    case tokenNotFound
}
