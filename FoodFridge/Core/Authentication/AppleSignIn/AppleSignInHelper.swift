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
                        let additionalUserInfo = authDataResult.additionalUserInfo
                        let profile = additionalUserInfo?.profile
                        
                        //save user id in session
                        self.sessionManager.saveLocalID(id: ("\(user.uid)"))
                        print("User apple ID: \(user.uid)")
                        print("saved apple local id = \(String(describing: self.sessionManager.getLocalID()))")
                        print("User apple Email: \(user.email ?? "N/A")")
                        print("User apple name: \(user.displayName ?? "user displayname")")
                        
                        // Get the ID token
                        user.getIDToken { idToken, error in
                            if let error = error {
                                print("Error getting ID token: \(error.localizedDescription)")
                                return
                            }
                            //save id token in session
                            if let idToken = idToken {
                                print("ID Token: \(idToken)")
                                // save id token in session
                                self.sessionManager.saveAuthToken(token: idToken)
                                print("saved id token apple = \(String(describing: self.sessionManager.getAuthToken()))")
                            } else {
                                print("ID Token is nil")
                            }
                        }
                        
                        /*
                         //MARK: TODO : save user data in firebase collection
                         //if sucess sign in, get user data save to firebase user collection
                         var name = String(localized: "NotDisplayName")
                         if let displayName = result?.user.displayName {
                         self.displayName = displayName
                         print("Apple display name = \(displayName)")
                         }
                         */
                        
                        print("apple signed in")
                        //update sign in state to true
                        UserDefaults.standard.set(true, forKey: "appleSignIn")
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
    
    //MARK: TODO this func use when same user sign in again in our app do not overwite user name if it's already exist.
    func updateDisplayName(for user: User, with appleIDCredential: ASAuthorizationAppleIDCredential, force: Bool = false) async {
        if let currentDisplayName = Auth.auth().currentUser?.displayName , !currentDisplayName.isEmpty {
            //current user is non-empty, don't overwrite it
        }
        else {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = self.displayName
            do {
                try await changeRequest.commitChanges()
                self.displayName = Auth.auth().currentUser?.displayName ?? "displayName"
            }catch {
                print("unable to update user's display name : \(error.localizedDescription)")
            }
        }
        
    }
}

