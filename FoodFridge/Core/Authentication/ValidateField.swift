//
//  Validate.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/12/24.
//

import Foundation
class ValidateField: ObservableObject  {
    
    @Published var fieldError: AuthenFieldError?
    @Published var fieldResetError: ResetPasswordError?
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validateResetField(email: String) -> Bool {
        do {
            //verify email not empty
            guard !email.isEmpty else {
                throw ResetPasswordError.filedEmpty
            }
            //verify email format
            guard isValidEmail(email) else {
                throw ResetPasswordError.invalidEmail
            }
            
            // If all validations pass, reset any previous error and return true
            self.fieldError = nil
            return true
            
        } catch let error as ResetPasswordError {
            self.fieldResetError = error
            return false
            
        }catch {
            return false
        }
    }

    func validateTextField(email: String, password: String, name: String?) ->Bool {
        
        do {
            guard !email.isEmpty && !password.isEmpty else {
                throw AuthenFieldError.allFieldEmpty
            }
            
            //if it sign up field and user don't fill name
            if let name, name.isEmpty {
                throw AuthenFieldError.nameEmpty
            }
            
            //if it sign up field and user put invalid email to sign up
            if name != nil,  !isValidEmail(email) {
                throw AuthenFieldError.invalidEmailSetUp
            }
                    
            //if it sign up field and user put invalid password to sign up
            if name != nil, password.count < 6 {
                throw AuthenFieldError.invalidPasswordSetUp
            }
                 
            guard !email.isEmpty else {
                throw AuthenFieldError.emailEmpty
            }
            
            guard !password.isEmpty else {
                throw AuthenFieldError.passwordEmpty
            }
            
            // if it log in field and user put invalid email to log in
            guard isValidEmail(email) else {
                throw AuthenFieldError.invalidCredentialEmail
            }
            
            // if it log in field and user put invalid password to log in 
            guard password.count >= 6 else {
                throw AuthenFieldError.invalidCredentailPassword
            }
            
            // If all validations pass, reset any previous error and return true
            self.fieldError = nil
            return true
            
        }catch let error as AuthenFieldError {
            //Catch and assign the specific AuthenFieldError to fieldError
            self.fieldError = error
            return false
            
        }catch {
            return false
        }
        
    }
    
}
enum ResetPasswordError: Error, LocalizedError {
    case filedEmpty
    case invalidEmail
    
    var textErrorDescription: String? {
        switch self {
        case .filedEmpty:
            return "Please enter your email"
        case .invalidEmail:
            return "Invalid Email"
        }
    }
}


enum AuthenFieldError: Error, LocalizedError {
    case allFieldEmpty
    case nameEmpty
    case emailEmpty
    case passwordEmpty
    case invalidEmailSetUp
    case invalidCredentialEmail
    case invalidPasswordSetUp
    case invalidCredentailPassword
    case unknowError
    
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
        case .invalidEmailSetUp:
            return "Invalid email"
        case .invalidPasswordSetUp:
            return "Invalid password set up. At least 6 characters"
        case .invalidCredentialEmail:
            return "Invalid credential"
        case .invalidCredentailPassword:
            return "Invalid credential"
        case.unknowError:
            return "Unknown error, please try again later"
        }
            
        }
    }

