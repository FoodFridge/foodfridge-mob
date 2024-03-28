//
//  SearchGoogleRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/30/24.
//

import Foundation
class LinkRecipeResource {
    
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func getLinkRecipe(recipeName: String) async throws -> [LinkRecipe] {
        // Create an instance of JSONEncoder
        let encoder = JSONEncoder()
        // Create request body
       
        
        guard let url = URL(string: AppConstant.linkRecipeResourceURLString) else {
                   throw URLError(.badURL)
               }
        //Encode request body to JSON data
        do {
            let token = sessionManager.getAuthToken()
            print("token = \(String(describing: token))")
            
            let localID = sessionManager.getLocalID()
            print("id = \(String(describing: localID))")
            
            
            let body = LinkRecipeRequestBody(localId: localID ?? "" , recipeName: recipeName)
            
            let jsonData = try encoder.encode(body)
            
            let userTimeZone  = UserTimeZone.getTimeZone()
              
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
                //if user is logged in add token and timeZone for authorization
                if UserDefaults.standard.bool(forKey: "userLoggedIn") {
                    guard let expTime = sessionManager.getExpTime() else {
                        throw SessionError.missingExpTime
                    }
                    request.setValue(userTimeZone, forHTTPHeaderField: "User-Timezone")
                    let returnNewToken = try await TokenManager.verifyTokenAndRequestNewToken(expTime: expTime, userTimeZone: userTimeZone, sessionManager: sessionManager)
                    if returnNewToken == nil {
                        // if token still valid use present token to fetch
                        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                    }else {
                        // use new token to fetch
                        request.setValue("Bearer \(returnNewToken ?? "")", forHTTPHeaderField: "Authorization")
                    }
                }
                
                
                
                
                // Make the request using URLSession
                let (data, response) = try await URLSession.shared.data(for: request)
               
                
                guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
                print("DEBUG: statusCode =  \(response)")

                // Handle the response
                if let responseText = String(data: data, encoding: .utf8) {
                 print("response = \(responseText)")
                }
                // Decode resonse data to LinkRecipe
                let responseData = try JSONDecoder().decode(LinkeRecipeResponseData.self, from: data)
                print("LinkRecipe = \(responseData.data)")
                return responseData.data
            
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            //detailed error info:
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(let key, let context):
                    print("Type mismatch for key \(key), \(context.debugDescription)")
                case .valueNotFound(let key, let context):
                    print("Value not found for key \(key), \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key not found \(key), \(context.debugDescription)")
                case .dataCorrupted(let context):
                    print("Data corrupted, \(context.debugDescription)")
                @unknown default:
                    print("Unknown error")
                }
            }
        }
        
        return LinkRecipe.mockLinkRecipes
    }
    
    
}
