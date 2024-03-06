//
//  LogInResponseData.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/16/24.
//

import Foundation
struct LogInResponseData: Codable {
    var data: LogInData
    
    struct LogInData: Codable {
        var localId : String?
        var token : String?
        var refreshToken : String?
    }
}

extension LogInResponseData {
    static let MOCKdata: LogInResponseData = LogInResponseData(data: LogInData(localId: nil, token: nil, refreshToken: nil))
    
}
