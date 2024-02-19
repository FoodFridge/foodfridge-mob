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
       
        do {
            guard let token = sessionManager.getAuthToken() else {
                throw SessionError.missingAuthToken
            }
            
            guard let localID = sessionManager.getLocalID() else {
                throw SessionError.missingLocalID
            }
            
            let urlEndpoint = ("\(AppConstant.fetchIngredientsURLString)/\(localID)")
            print("ingredient url =\(urlEndpoint)")
            
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
            
            var request = URLRequest(url: url)
                   request.httpMethod = "GET"
                   request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                   
            let (data, response) = try await URLSession.shared.data(for: request)
                   
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            //print("DEBUG: statusCode =  \(response)")
            
            let jsonData = try decoder.decode(IngredientData.self, from: data)
            //get all ingredients
            //self.ingredients = jsonData.data
            // get all ingredients by type
            self.ingredientsByType = Dictionary(grouping: jsonData.data, by: { $0.type })
            //print("jsondata = \(ingredientsByType)")
            return self.ingredientsByType
            
        } catch {
            print("Error decoding get ingredient JSON: \(error)")
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
        return ["01" : IngredientItem.mockItems]
    }

    
}

enum SessionError: Error {
    case missingAuthToken
    case missingLocalID
}
