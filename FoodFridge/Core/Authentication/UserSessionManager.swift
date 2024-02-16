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
    
    // Save Local ID
    func saveLocalID(id: String) {
        try? keychain.set(id, key: "localID")
    }
    
    // Get Local ID
    func getLocalID() -> String? {
        try? keychain.get("localID")
    }
    
    // Check if User is Logged In
    func isLoggedIn() -> Bool {
        getAuthToken() != nil
    }
    
    // Logout User
    func logout() {
        try? keychain.remove("authToken")
        try? keychain.remove("localID")
    }
}
