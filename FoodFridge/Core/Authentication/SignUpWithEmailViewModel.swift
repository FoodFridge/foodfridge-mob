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
   
    @Published var sessionData = LogInResponseData.MOCKdata.data
    
    @Published var signupError: SignupError?
    
    
    func signUpUser(sessionManager: SessionManager)async throws -> Bool {
        
        
        do {
            print("view model call service")
            //call service class
            try await SignUpWithEmail(sessionManager: sessionManager).signUp(email: self.email.lowercased(), password: self.password, name: self.name)
            
            //if sign up success, then log in
            try await LoginWithEmailService(sessionManager: sessionManager).login(email: self.email.lowercased(), password: self.password)
                
            return true
          
         
        } catch let error as SignupError {
            self.signupError  = error
            print ("sign up Error = \(String(describing: signupError))")
            
            
        } catch {
            print("Sign up failed with error : \(error.localizedDescription)")
        }
        return false
    }
}
