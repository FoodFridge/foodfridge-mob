//
//  GetFavoriteRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation
class GetFavoriteRecipe {
    var favRecipes: [FavoriteRecipe] = [FavoriteRecipe]()
    
    
    let sessionManager: SessionManager
        
        init(sessionManager: SessionManager) {
            self.sessionManager = sessionManager
        }
    
    func getLinkRecipe(isFavorite: String = "Y") async throws -> [FavoriteRecipe] {
        
        let decoder = JSONDecoder()
    
         
        do {
            guard let token = sessionManager.getAuthToken() else {
                throw SessionError.missingAuthToken
            }
            
            guard let localID = sessionManager.getLocalID() else {
                throw SessionError.missingLocalID
            }
            
            let urlEndpoint = ("\(AppConstant.getFavoriteRecipeOfuserUSLString)/\(localID)/\(isFavorite)")
        
            
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
           // print("get fave url = \(url)")
            
            let userTimeZone  = UserTimeZone.getTimeZone()
            var request = URLRequest(url: url) 
                   request.httpMethod = "GET"
                   request.setValue(userTimeZone, forHTTPHeaderField: "User-Timezone")
                   request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
                   
            let (data, response) = try await URLSession.shared.data(for: request)
                   
            let jsonData = try decoder.decode(FavoriteRecipeResponse.self, from: data)
            
           // print("decoded data = \(jsonData)")
            
            // Print the JSON string for debugging
           // if let responseText = String(data: data, encoding: .utf8){
                //print("JSON String: \(responseText )")
           // }
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            //print("DEBUG: statusCode =  \(response)")
            let jsonString = String(data: data, encoding: .utf8)
            //print("favorite recipes JSON String: \(jsonString ?? "N/A")")
            
            
            return jsonData.data
            
        } catch {
            print(error.localizedDescription)
        }
        return [FavoriteRecipe]()
    }
   
}
