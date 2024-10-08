//
//  GetFavoriteRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation
class GetFavoriteRecipe {
    //var favRecipes: [FavoriteRecipe] = [FavoriteRecipe]()
    
    
    let sessionManager: SessionManager
        
        init(sessionManager: SessionManager) {
            self.sessionManager = sessionManager
        }
    
    func getLinkRecipe(isFavorite: String = "Y") async throws -> [RecipeLink] {
        
        let decoder = JSONDecoder()
    
         
        do {
            //guard let token = sessionManager.getAuthToken() else {
                //throw SessionError.missingAuthToken
            //}
            
            guard let localID = sessionManager.getLocalID() else {
                throw SessionError.missingLocalID
            }
            
            //guard let expTime = sessionManager.getExpTime() else {
                //throw SessionError.missingExpTime
            //}
            
            let urlEndpoint = ("\(AppConstant.getFavoriteRecipeOfuserUSLString)/\(localID)")
            print ("get fav of user endPoint = \(urlEndpoint)")
            
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
           // print("get fave url = \(url)")
            
            //Make a request
            //let userTimeZone  = UserTimeZone.getTimeZone()
            var request = URLRequest(url: url)
                   request.httpMethod = "GET"
                   //request.setValue(userTimeZone, forHTTPHeaderField: "User-Timezone")
                   
            /*
            //if user is logged in add token and timeZone for authorization
            if UserDefaults.standard.bool(forKey: "userLoggedIn") {
                let returnNewToken = try await TokenManager.verifyTokenAndRequestNewToken(expTime: expTime, userTimeZone: userTimeZone, sessionManager: sessionManager)
                if returnNewToken == nil {
                    // if token still valid use present token to fetch
                    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                }else {
                    // use new token to fetch
                    request.setValue("Bearer \(returnNewToken ?? "")", forHTTPHeaderField: "Authorization")
                }
            }
            
            */
                   
            let (data, response) = try await URLSession.shared.data(for: request)
                   
            let jsonData = try decoder.decode([RecipeLink].self, from: data)
            
           print("fav recipes = \(jsonData)")
            
            // Print the JSON string for debugging
           // if let responseText = String(data: data, encoding: .utf8){
                //print("JSON String: \(responseText )")
           // }
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            //print("DEBUG: statusCode =  \(response)")
            //let jsonString = String(data: data, encoding: .utf8)
            //print("favorite recipes JSON String: \(jsonString ?? "N/A")")
            
            
            return jsonData
            
        } catch {
            print(error.localizedDescription)
        }
        return [RecipeLink]()
    }
   
}
