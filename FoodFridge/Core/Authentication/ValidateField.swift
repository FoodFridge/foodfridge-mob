//
//  Validate.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/12/24.
//

import Foundation
class ValidateField: ObservableObject  {
    
    @Published var loginFieldError: AuthenFieldError?
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    func validateTextField(email: String, password: String, name: String?) ->Bool {
        
        do {
            guard !email.isEmpty && !password.isEmpty else {
                throw AuthenFieldError.allFieldEmpty
            }
              
            if let name, name.isEmpty {
                throw AuthenFieldError.nameEmpty
            }
                    
            guard !email.isEmpty else {
                throw AuthenFieldError.emailEmpty
            }
            
            guard !password.isEmpty else {
                throw AuthenFieldError.passwordEmpty
            }
                
            guard isValidEmail(email) else {
                throw AuthenFieldError.invalidEmail
            }
            
            guard password.count >= 6 else {
                throw AuthenFieldError.invalidPassword
            }
            
            // If all validations pass, reset any previous error and return true
            self.loginFieldError = nil
            return true
            
        }catch let error as AuthenFieldError {
            //Catch and assign the specific AuthenFieldError to loginFieldError
            self.loginFieldError = error
            return false
            
        }catch {
            return false
        }
        
       
    }
}


enum AuthenFieldError: Error, LocalizedError {
    case allFieldEmpty
    case nameEmpty
    case emailEmpty
    case passwordEmpty
    case invalidEmail
    case invalidPassword
    
    var textErrorDescription: String? {
        switch self {
        case .allFieldEmpty:
            return "Please fill all fields"
        case .nameEmpty:
            return "Please fill name"
        case .emailEmpty:
            return "Please fill email"
        case .passwordEmpty:
            return "Please fill password"
        case .invalidEmail:
            return "Invalid email"
        case .invalidPassword:
            return "Invalid password. at least 6 characters"
            
        }
            
        }
    }

