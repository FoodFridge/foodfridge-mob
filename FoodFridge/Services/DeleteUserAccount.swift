//
//  DeleteUserAccount.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 4/18/24.
//

import Foundation
class DeleteUserAccount: ObservableObject {
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func deleteUser() async throws -> Bool {
        
        guard let url = URL(string: AppConstant.deleteUserAccountURLString) else { throw URLError(.badURL)}
        
        do {
            let localID = sessionManager.getLocalID()
            print("deleting user id = \(String(describing: localID))")
            let requestBody = try? JSONSerialization.data(withJSONObject: ["localId": localID], options: [])
            let userTimeZone  = UserTimeZone.getTimeZone()
            // URL request object with URL and request method
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue(userTimeZone, forHTTPHeaderField: "User-Timezone")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.serverError }
            print("DEBUG: statusCode =  \(response)")
            
            return true
            
        }catch {
            print("Error deleting user account: \(error)")
        }
        
        return false
    }
    
}
