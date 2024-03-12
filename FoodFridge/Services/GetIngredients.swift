//
//  FetchIngredientsLocal.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/17/24.
//

import Foundation
import SwiftUI

class GetIngredients {
    
    var ingredients: [IngredientItem] = []
    var ingredientsByType: [String: [IngredientItem]] = [:]
    
    let sessionManager: SessionManager
        
        init(sessionManager: SessionManager) {
            self.sessionManager = sessionManager
        }
    
    static func GetIngredients() throws -> [IngredientItem] {
        
        var returnJson: [IngredientItem]
        
        if let url = Bundle.main.url(forResource: "Ingredients", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                if let ingredients = IngredientParser.parseIngredients(from: data) {
                    
                    // Print the JSON string for debugging
                        //let jsonString = String(data: data, encoding: .utf8)
                       // print("JSON String: \(jsonString ?? "N/A")")
                    
                    // Now you have an array of 'Ingredient' objects
                    //for ingredient in ingredients {
                       // print("ID: \(ingredient.id),Name: \(ingredient.name), Type Code: \(ingredient.type)")
                    //}
                    
                    
                    returnJson = ingredients
                    return returnJson
                }
                
            }catch {
                print("Error loading and decoding JSON: \(error.localizedDescription)")
            }
        }
        return  IngredientItem.mockItems
    }
    
   func loadIngredients() async throws -> [String: [IngredientItem]] {
       
        let decoder = JSONDecoder()
       /*
        guard let url = Bundle.main.url(forResource: "Ingredients", withExtension: "json"),
             let data = try? Data(contentsOf: url) else {
           print("JSON file was not found")
           return ["1" : IngredientItem.mockItems] }
    */
       
        do {
            
            let token = sessionManager.getAuthToken()
            print("ingredient token = \(String(describing: token))")
            
            let localID = sessionManager.getLocalID()
            print("ingredient user id = \(String(describing: localID))")
            
            let expTime = sessionManager.getExpTime()
            print("ingredient exp time = \(String(describing: expTime))")
            
            let urlEndpoint = ("\(AppConstant.fetchIngredientsURLString)")
            print("ingredient url =\(urlEndpoint)")
            
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
            
            //JSON data  and token to be sent to the server, handled both unloggedIn user and loggedIn user
            let requestBody = try? JSONSerialization.data(withJSONObject: ["localId": localID], options: [])
            let userTimeZone  = UserTimeZone.getTimeZone()
            let timeStamp = UserTimeZone.getCurrentTimestamp()
            
            var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.httpBody = requestBody  
    
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(userTimeZone, forHTTPHeaderField: "User-Timezone")
           
            
         
            //if user is logged in
            if UserDefaults.standard.bool(forKey: "userLoggedIn") {
                let returnNewToken = try await TokenManager.verifyTokenAndRequestNewToken(expTime: expTime ?? Date.timeIntervalSinceReferenceDate, userTimeZone: userTimeZone, sessionManager: sessionManager)
                print("returnNewToken in checking user default = \(String(describing: returnNewToken))")
                if returnNewToken == nil {
                    // if token still valid use present token to fetch
                    request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                    request.setValue(timeStamp, forHTTPHeaderField: "TimeStamp")
                }else {
                    // use new token to fetch
                    request.setValue("Bearer \(returnNewToken ?? "")", forHTTPHeaderField: "Authorization")
                    request.setValue(timeStamp, forHTTPHeaderField: "TimeStamp")
                }
                
                
                print("request header token = \(String(describing: request.value(forHTTPHeaderField: "Authorization")))")
                print("request header timeStamp  = \(String(describing: request.value(forHTTPHeaderField: "TimeStamp")))")
               
                /*
                //verify token is valid before request api
                if  TokenManager.isTokenExpired(expiryDateUnix: expTime ?? Date.timeIntervalSinceReferenceDate, userTimeZoneIdentifier: userTimeZone) {
                    print("token expired!")
                    //if it expired remove expired token of session
                    sessionManager.removeToken()
                    print("removed token and exp time")
                    
                    do {
                        // then request new token
                        let newTokenResponse = try await TokenManager.requestNewToken(sessionmanager: sessionManager)
                        print("new token = \(String(describing: newTokenResponse?.token))")
                        
                        // Set Authorization header with new token
                        if let newTokenResponse = newTokenResponse {
                            request.setValue("Bearer \(newTokenResponse.token)", forHTTPHeaderField: "Authorization")
                            // save new token in session
                            sessionManager.saveAuthToken(token: newTokenResponse.token)
                            let savedNewToken = sessionManager.getAuthToken()
                            print("savedNewToken in session = \(String(describing: savedNewToken))")
                            // save new expTime in session
                            sessionManager.saveExpTime(exp: newTokenResponse.expTime)
                            let savedNewExp = sessionManager.getExpTime()
                            print("savedNewExp = \(String(describing: savedNewExp))")
                            
                        } else {
                            // Handle the case where the new token is nil
                            // Throw an error if the new token is nil
                            throw TokenError.tokenNotFound
                        }
                        
                    }
                    catch{
                        print("Error requesting new token: \(error)")
                    }
                }
                else {
                    // if token still valid use present token to fetch
                    request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                }
                 */
                
            }
            
          
            
            
            let (data, response) = try await URLSession.shared.data(for: request)
                   
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { 
                print("DeBug: cannot fetch ingredients = \(response)")
                throw FetchError.serverError }
            print("DEBUG: ingredient load statusCode =  \(response)")
            
            let jsonData = try decoder.decode(IngredientData.self, from: data)
            //get all ingredients
            //self.ingredients = jsonData.data
            // get all ingredients by type
            self.ingredientsByType = Dictionary(grouping: jsonData.data, by: { $0.type })
           // print("jsondata = \(ingredientsByType)")
            return self.ingredientsByType
            
        } catch {
            print("Error decoding get ingredient JSON: \(error)")
          
        }
        return ["07" : IngredientItem.mockItems]
    }

    
}


