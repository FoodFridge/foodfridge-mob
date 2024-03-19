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
            
                    //get email and firebase UID to Auth user with our app
                    if let userEmail = user.email {
                        Task {
                            //Auth user with app and save user session info in AuthwithApp function
                            do {
                                let successAuthWithApp = try await AuthUserWithApp.auth(email: userEmail , userId: user.uid , sessionManager: self.sessionManager )
                                if successAuthWithApp {
                                    print("google signed in")
                                }
                            }catch {
                                print("got error AuthWithApp = \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
    }
    
}
     
    
