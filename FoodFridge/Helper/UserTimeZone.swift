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
    
    static func getCurrentTimestamp() -> String {
           let currentDate = Date()
           
           // Get user's time zone
           let userTimeZone = TimeZone.current
           
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           dateFormatter.timeZone = userTimeZone
           
           return dateFormatter.string(from: currentDate)
       }
}
