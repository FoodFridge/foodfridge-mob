//
//  FetchIngredients.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/16/24.
//

import Foundation

class FetchIngredients {
    
    func fetchIngedients() async throws -> IngredientData {
        
        var fetchedIngredients: IngredientData
        let urlEndpoint = AppConstant.fetchIngredientsURLStinng
        
        do {
            guard let url = URL(string: urlEndpoint) else
            { throw FetchError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: statusCode =  \(response)")
            
            let dataString = String(data: data, encoding: .utf8)
            print("DEBUG: dataString =  \(String(describing: dataString))")
            
            guard let jsondata = try? JSONDecoder().decode(IngredientData.self, from: data) else { return IngredientData(status:"test", message: "test", data: IngredientItem.mockItems) }
            print("DEBUG: jsonData = \(jsondata)")
            
            fetchedIngredients = jsondata
            print("DEBUG: fetchedIngredients = \(fetchedIngredients)")
            
            return fetchedIngredients
            
        }catch {
            print(error.localizedDescription)
        }
        
        return IngredientData(status: "test", message: "test", data: IngredientItem.mockItems)
    }
}

enum FetchError: Error, LocalizedError {
case invalidURL
case serverError
case parsingJson
case unknown(Error)

var errorDescription: String? {
    switch self{
    case .invalidURL:
        return " The URL was invalid"
    case .serverError:
        return "There was an error with the server for fetching data, please try again"
        
    case .parsingJson:
        return "Cannot parsing JsonData"
        
    case.unknown(let error):
        return error.localizedDescription
    }
    
}
}

