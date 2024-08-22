//
//  AppleSignInHelper.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/21/24.
//

import Foundation
import SwiftUI
import CryptoKit
import AuthenticationServices
import FirebaseAuth

class AppleSignInHelper: ObservableObject {
    
    var displayName = ""
    var userEmail = "appleUser@apple.com"
    
    fileprivate var currentNonce: String?
    
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func handleSignInWithAppleRequest(_ request: ASAuthorizationOpenIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.requestedScopes = [.fullName,.email]
        request.nonce = sha256(nonce)
    }
    
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        
        switch result {
            
        case .success(let success):
            
            if let appleCredential = success.credential as? ASAuthorizationAppleIDCredential  {
              
                guard let nonce = currentNonce else {
                    print("completion currentNonce = \(String(describing: currentNonce))")
                    fatalError("Invalid state: a login call back was recived, but no login request was sent")
                }
                guard let token = appleCredential.identityToken else {
                    print("Unable to fetch identity token")
                    return
                }
                guard let tokenString = String(data: token, encoding:  .utf8) else {
                    print("Unable to serialise token string from data :\(token.debugDescription)")
                    return
                }
                
                //get credential of user from apple.com
                let credential = OAuthProvider.appleCredential(withIDToken: tokenString,
                                                               rawNonce: nonce,
                                                               fullName: appleCredential.fullName)
               
                //sign in firebase apple auth with credential
                Auth.auth().signIn(with: credential) {(result, error) in
                    //check error
                    if let error = error {
                        print("error with firebase result: \(error.localizedDescription)")
                        print("rawNonce for credential = \(String(describing: self.currentNonce))")
                        return
                    }
                   
                    if let authDataResult = result {
                        let user = authDataResult.user
                        print("userData = \(user)")
                        print("email = \(String(describing: user.email))")
                        print("id = \(user.uid)")
                        
                        //get email and firebase UID to Auth user with our app if user email is nil assign mock email
                        Task {
                                //Auth user with app and save user session info in AuthwithApp function
                                do {
                                    let successAuthWithApp = try await AuthUserWithApp.auth(email: user.email ?? self.userEmail , userId: user.uid , sessionManager: self.sessionManager )
                                    if successAuthWithApp {
                                        print("apple signed in")
                                    }
                                }catch {
                                    print("got error AuthWithApp = \(error.localizedDescription)")
                                }
                        }
                    }
                }
            }
        
        case .failure(let failure):
            print("result of request fail :\(failure.localizedDescription)")
            
        }
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
   
}

