//
//  UserData.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/16/24.
//

import Foundation
struct UserData: Codable {
    let id: String
    let email: String
    let name: String
}
extension UserData {
    static var mockData: UserData {
        UserData(id: "mockId", email: "MockEmail", name: "MockName")
    }
}
