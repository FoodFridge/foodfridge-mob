//
//  UserSessionManager.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/16/24.
//

import Foundation
import KeychainAccess

class SessionManager: ObservableObject {
    private let keychain = Keychain(service: "com.foodfridge.jessie.FoodFridge")
    
    // Save Auth Token
    func saveAuthToken(token: String) {
        try? keychain.set(token, key: "authToken")
    }
    
    // Get Auth Token
    func getAuthToken() -> String? {
        try? keychain.get("authToken")
    }
    
    //remove expired Token
        func removeToken() {
            try? keychain.remove("authToken")
        }
    
    // Save Local ID
    func saveLocalID(id: String) {
        try? keychain.set(id, key: "localID")
    }
    
    // Get Local ID
    func getLocalID() -> String? {
        try? keychain.get("localID")
    }
    
    
    // Get Refresh token
    func getRefreshToken() -> String? {
        try? keychain.get("refreshToken")
    }
    
    // Refresh Token
    func saveRefreshToken(token: String) {
        try? keychain.set(token, key: "refreshToken")
    }
    
    
    // Get exp time of token
      func getExpTime() -> TimeInterval? {
          guard let expTimeString = try? keychain.get("expTime"),
                let expTime = TimeInterval(expTimeString) else {
              return nil
          }
          return expTime
      }
      
      // Save exp time stamp
      func saveExpTime(exp: TimeInterval) {
          let expTimeString = "\(exp)"
          try? keychain.set(expTimeString, key: "expTime")
      }
      
    
    
    // Check if User is Logged In
    func isLoggedIn() -> Bool {
        getAuthToken() != nil
    }
    
    // Logout User
    func logout() {
           try? keychain.remove("authToken")
           try? keychain.remove("localID")
           try? keychain.remove("refreshToken")
           try? keychain.remove("expTime")
       }
    
    
    
    
    
}
