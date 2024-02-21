//
//  GoogleSignInFunction.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/20/24.
//

import Foundation
import Firebase
import GoogleSignIn

class GoogleSignInHelper {
    
    let sessionManager: SessionManager
        
        init(sessionManager: SessionManager) {
            self.sessionManager = sessionManager
        }
    
    
     func SignInWithGoogle(from viewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) {  result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
               return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // sign in user with google
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    //TODO: manage error
                    return
                }
            
                if let authDataResult = result { // Assuming authDataResult is the variable containing FIRAuthDataResult
                    let user = authDataResult.user
                    let additionalUserInfo = authDataResult.additionalUserInfo
                    
                    //save user id in session
                    self.sessionManager.saveLocalID(id: ("\(user.uid)"))
                    print("User ID: \(user.uid)")
                    print("saved local id = \(String(describing: self.sessionManager.getLocalID()))")
                    //print("User Email: \(user.email ?? "N/A")")
                    // Print other user properties as needed
                    /*
                    if let profile = additionalUserInfo?.profile {
                        // If additional user info is available
                        print("Additional User Info:")
                        for (key, value) in profile {
                            print("\(key): \(value)")
                        }
                    }
                    */
                    
                    
                    // Get the ID token
                    user.getIDToken { idToken, error in
                        if let error = error {
                            print("Error getting ID token: \(error.localizedDescription)")
                            return
                        }
                        
                        if let idToken = idToken {
                            print("ID Token: \(idToken)")
                            // save id token in session
                            self.sessionManager.saveAuthToken(token: idToken)
                            print("saved id token = \(String(describing: self.sessionManager.getAuthToken()))")
                        } else {
                            print("ID Token is nil")
                        }
                    }
                    
                    
                    
                    
                    
                    print("google signed in")
                    UserDefaults.standard.set(true, forKey: "googleSignIn")
                    
                }
             
                
            }
            
        }
     
    }
}
