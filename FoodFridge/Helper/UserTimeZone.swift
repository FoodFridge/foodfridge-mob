//
//  UserTimeZone.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/5/24.
//

import Foundation
class UserTimeZone: ObservableObject {
    static func getTimeZone() -> String {
        let timeZone = TimeZone.current.identifier
        return timeZone
    }
}
