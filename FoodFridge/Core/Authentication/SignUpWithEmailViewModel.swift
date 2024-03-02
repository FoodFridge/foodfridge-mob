//
//  SignUpWithEmailViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import Foundation

@MainActor
class SignUpWithEmailViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var isSignUpSuccess = false
    @Published var showProgressView = false
    @Published var sessionData = LogInResponseData.MOCKdata.data
    
    
    
    func signUpUser(sessionManager: SessionManager)async throws -> Bool {
        showProgressView = true
        do {
            //call service class
            let result =  try await SignUpWithEmail(sessionManager: sessionManager).signUp(email: self.email, password: self.password, name: self.name)
            //call log in after sign up
            self.sessionData = try await LoginWithEmailService(sessionManager: sessionManager).login(email: self.email, password: self.password)
            
            showProgressView = false
            
            return result
            
        } catch {
            showProgressView = false
            print("Sign up failed with error : \(error.localizedDescription)")
            
        }
        return false
    }
}
