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
            print("token = \(String(describing: token))")
            
            let localID = sessionManager.getLocalID()
            print("id = \(String(describing: localID))")
            
            let urlEndpoint = ("\(AppConstant.fetchIngredientsURLString)")
            print("ingredient url =\(urlEndpoint)")
            
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
            
            //JSON data  and token to be sent to the server, handled both unloggedIn user and loggedIn user
            let requestBody = try? JSONSerialization.data(withJSONObject: ["localId": localID], options: [])
            let userTimeZone  = UserTimeZone.getTimeZone()
            
            var request = URLRequest(url: url)
                   request.httpMethod = "POST"
                   request.httpBody = requestBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(userTimeZone, forHTTPHeaderField: "User-Timezone")
            
            //verify token is valid to use
            if let expDateToken = TokenManager.decodeJWTExpiration(token: token ?? "") {
                if sessionManager.isTokenExpired(expiryDate: expDateToken) {
                    //if token expired, request new token
                    let newToken = try await TokenManager.requestNewToken(sessionmanager: sessionManager)
                    request.setValue("Bearer \(newToken)", forHTTPHeaderField: "Authorization")
                    //and save it in session
                    sessionManager.saveAuthToken(token: newToken)
                }else {
                    request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                }
                
            }
                
            
            
            let (data, response) = try await URLSession.shared.data(for: request)
                   
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
           // print("DEBUG: statusCode =  \(response)")
            
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

enum SessionError: Error {
    case missingAuthToken
    case missingLocalID
}
