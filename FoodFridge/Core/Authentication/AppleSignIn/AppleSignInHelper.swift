//
//  AppleSignInHelper.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/21/24.
//

import Foundation
import CryptoKit
import AuthenticationServices

class AppleSignInHelper: ObservableObject {
    @Published var nonce = ""
    
    func handleSignInWithAppleRequest(_ request: ASAuthorizationOpenIDRequest) {
        
        
    }
    
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
           
        case .success(let user):
            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                print("credential none")
                return
            }
            guard let token = credential.identityToken else {
                print("error with token")
                return
            }
            guard let tokenString = String(data: token, encoding:  .utf8) else {
                print("error with token string")
                return
            }
        case .failure(let failure):
            print("\(failure.localizedDescription)")
     
        }
    }
}

