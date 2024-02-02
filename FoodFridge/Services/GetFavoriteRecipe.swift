//
//  GetFavoriteRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import Foundation
class GetFavoriteRecipe {
    var favRecipes: [LinkRecipe] = [LinkRecipe]()
    
    static func getLinkRecipe(userId: String, isFavorite: String) async throws -> [LinkRecipe] {
        let decoder = JSONDecoder()
        let urlEndpoint = ("\(AppConstant.getFavoriteRecipeOfuserUSLString)/\(userId)/\(isFavorite)")
        print("user id = \(userId)")
        guard let url = URL(string: urlEndpoint) else
        { throw FetchError.invalidURL }
        print("url = \(url)")
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let jsonData = try decoder.decode(FavoriteLinkRecipe.self, from: data)
        
        print("decoded data = \(jsonData)")
        
        // Print the JSON string for debugging
        if let responseText = String(data: data, encoding: .utf8){
            print("JSON String: \(responseText )")
        }
        
        guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
        print("DEBUG: statusCode =  \(response)")
        
        
        return jsonData.data
        
    }
    
}
