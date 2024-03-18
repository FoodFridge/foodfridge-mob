//
//  LogInWithEmailViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/16/24.
//

import Foundation

@MainActor
class LogInWithEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var loginError: LogInError?
    
    func logIn(sessionManager: SessionManager)async throws -> Bool {
        
            do {
                print("view model call login service")
                try await LoginWithEmailService(sessionManager: sessionManager).login(email: self.email, password: self.password)
                return true
            }catch let error as LogInError {
                self.loginError = error
                print ("sign up view model Error = \(String(describing: loginError))")
                return false
            }catch {
                print("Log in failed with error : \(error.localizedDescription)")
                
            }
            return false
       
    }
}
