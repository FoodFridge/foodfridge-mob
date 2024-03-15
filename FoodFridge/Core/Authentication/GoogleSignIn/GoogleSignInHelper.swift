//
//  GoogleSignInHelper.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/21/24.
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
        
        // Create Google Sign In configuration object
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in with google to get user info and idtoken form gg
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) {  result, error in
            guard error == nil else {
                print("error auth with google = \(error?.localizedDescription as Any) ")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("error get user idToken from gg = \(error?.localizedDescription as Any) ")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // After get credentail from gg sign in user with Firebase auth
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    //TODO: manage error
                    print("cannot auth user with Firebase = \(String(describing: error?.localizedDescription))")
                    return
                }
                
                if let authDataResult = result { // Assuming authDataResult is the variable containing FIRAuthDataResult
                    let user = authDataResult.user
                    let additionalUserInfo = authDataResult.additionalUserInfo
                    
                    //get email and firebase UID to Auth user with our app
                    if let userEmail = user.email {
                        Task {
                            //Auth user with app and save user session info in AuthwithApp function
                            do {
                                let authWithAppResult = try await AuthUserWithApp.auth(email: userEmail , userId: user.uid , sessionManager: self.sessionManager )
                                print("google signed in")
                            }catch {
                                print("got error AuthWithApp = \(error.localizedDescription)")
                            }
                        }
                    }
                    
                    
                }
            }
            
            
            
            
            
            /* delete when done
            
            
            
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
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            
            */
            
        }
        
        
    }
    
}
     
    
