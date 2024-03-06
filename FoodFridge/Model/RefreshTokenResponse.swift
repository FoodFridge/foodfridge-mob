//
//  RefreshTokenResponse.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/5/24.
//

import Foundation
struct RefreshTokenResponse: Codable {
    let message: String
    let token: String
}
