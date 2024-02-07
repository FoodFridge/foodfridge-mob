//
//  GetFavoriteRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation
class GetFavoriteRecipe {
    var favRecipes: [FavoriteRecipe] = [FavoriteRecipe]()
    
    static func getLinkRecipe(userId: String, isFavorite: String) async throws -> [FavoriteRecipe] {
        /*
        guard let url = Bundle.main.url(forResource: "FavoriteRecipes", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("JSON file was not found")
            return [FavoriteRecipe]()
        }
        */
        
        let decoder = JSONDecoder()
        let urlEndpoint = ("\(AppConstant.getFavoriteRecipeOfuserUSLString)/\(userId)/\(isFavorite)")
        print("user id = \(userId)")
        guard let url = URL(string: urlEndpoint) else
        { throw FetchError.invalidURL }
        print("url = \(url)")
        
         let (data, response) = try await URLSession.shared.data(from: url)
        do {
            let jsonData = try decoder.decode(FavoriteRecipeResponse.self, from: data)
            
            print("decoded data = \(jsonData)")
            
            // Print the JSON string for debugging
            if let responseText = String(data: data, encoding: .utf8){
                print("JSON String: \(responseText )")
            }
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: statusCode =  \(response)")
            let jsonString = String(data: data, encoding: .utf8)
            print("favorite recipes JSON String: \(jsonString ?? "N/A")")
            
            
            return jsonData.data
            
        } catch {
            print(error.localizedDescription)
        }
        return [FavoriteRecipe]()
    }
   
}
