//
//  AuthUserWithApp.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/14/24.
//

import Foundation
class AuthUserWithApp {
    
    static func auth(email : String, userId : String, sessionManager: SessionManager) async throws -> Bool {
       
        let urlEndPoint = AppConstant.authWithAppURLString
        
        guard let url = URL(string: urlEndPoint) else { throw URLError(.badURL)}
        
        do {
            let userTimeZone  = UserTimeZone.getTimeZone()
            //create request object, http method and header
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type" )
            request.setValue(userTimeZone, forHTTPHeaderField: "User-Timezone")
            //JSON data to be sent to the server
            let jsonData = try? JSONSerialization.data(withJSONObject: ["email": email, "localId": userId], options: [])
            request.httpBody = jsonData
            
            //sent network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: Auth statusCode =  \(response)")
            
            //decode response data
            let jsonResponse = try JSONDecoder().decode(LogInResponseData.self, from: data)
            
            // Print the JSON string for debugging
            let jsonString = String(data: data, encoding: .utf8)
            print("JSON String: \(jsonString ?? "N/A")")
            
            //Save userData in Session
            //save token in session
            guard let token = jsonResponse.data.token else{
                throw FetchError.serverError
            }
            sessionManager.saveAuthToken(token: token)
            let savedLogIntoken = sessionManager.getAuthToken()
            print("Auth token = \(String(describing: savedLogIntoken))")
            
            //save id in session
            guard let localID = jsonResponse.data.localId else{
                throw FetchError.serverError
            }
            sessionManager.saveLocalID(id: localID)
            let savedLogInlocalID = sessionManager.getLocalID()
            print("Auth ID = \(String(describing: savedLogInlocalID))")
            
            //save refreshToken in session
            guard let refreshToken = jsonResponse.data.refreshToken else{
                throw FetchError.serverError
            }
            sessionManager.saveRefreshToken(token: refreshToken)
            let savedRefreshToken = sessionManager.getRefreshToken()
            print("Auth refresh token = \(String(describing: savedRefreshToken))")
            
            
            //save expTime in session
            guard let expTime = jsonResponse.data.expTime else {
                throw FetchError.serverError
            }
            sessionManager.saveExpTime(exp: expTime)
            let savedExp = sessionManager.getExpTime()
            print("Auth exp time = \(String(describing: savedExp))")
            
            //update log in state to true
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            //if successfully
            print("Auth with app successfully")
            
            return true
            
            
        } catch {
            print("Auth with app Error: \(error.localizedDescription)")
        }
        
        return false
    }
}
