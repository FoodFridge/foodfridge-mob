//
//  IngredientsParser.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/17/24.
//

import Foundation

class IngredientParser {
    static func parseIngredients(from jsonData: Data) -> [IngredientItem]? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(IngredientData.self, from: jsonData)
            return result.data
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
