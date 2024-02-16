//
//  SignUpWithEmailViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import Foundation
class SignUpWithEmailViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var isSignUpSuccess = false
    
    
    
    
    func signUpUser()async throws {
        //call service class
        do {
            
            //let signUpService = SignUpWithEmail(navigationController: navigationController)
            try await SignUpWithEmail().signUp(email: self.email, password: self.password, name: self.name)
            
        } catch {
            print("Sign up failed with error : \(error.localizedDescription)")
            
        }
    }
}
