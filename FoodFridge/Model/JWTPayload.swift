//
//  JWTPayload.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/5/24.
//

import Foundation
struct JWTPayload: Decodable {
    let localId: String
    let exp: Date
}
