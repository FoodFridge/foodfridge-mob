//
//  AuthenticationView2.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/13/24.
//

import SwiftUI
import AuthenticationServices

struct AuthenticationView2: View {
    @State private var signUpWithEmailShow: Bool = false
    @State private var signUpWithGoogleShow: Bool = false
    @State private var signUpWithAppleShow: Bool = false
    @State private var landingPageShow: Bool = false
    @State private var logInPageShow: Bool = false
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var appleSignIn: AppleSignInHelper
    
  

    var body: some View {
        NavigationStack {
            if sessionManager.getAuthToken() != nil {
                LandingPageView()
            } else {
                GeometryReader { proxy in
                    VStack {
                        HStack {
                            
                            Spacer()
                            //MARK: Image
                            Image("cooking")
                                .resizable()
                                .frame(width: 270, height: 270)
                                .scaledToFit()
                                .offset(x: 20, y: 20)
                            Spacer()
                            
                            //MARK: Skip link to landing page
                            
                             NavigationLink {
                             
                             } label: {
                             Text("        ")
                             
                             }
                             .padding(.trailing, -10)
                             .offset(y: -130)
                             
                            
                        }
                        VStack {
                            Text("Ready to explore new menu ?")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .padding(.leading, 35)
                            
                        }
                        .font(Font.custom("CourierPrime-Bold", size: 26))
                        .padding(.top, 10)
                        .frame(width: proxy.size.width)
                        .padding(.leading, -30)
                        
                        //MARK: Buttons for create account and sign in
                        //create account with email
                        VStack {
                            LoginButton(title:"Create account") {
                                self.signUpWithEmailShow = true
                            }
                            .sheet(isPresented: $signUpWithEmailShow, content: {
                                SignUpWithEmailView()
                            })
                            
                            
                            LoginButton(title:"Sign in with Email") {
                                self.logInPageShow = true
                            }
                            .sheet(isPresented: $logInPageShow, content: {
                                LogInView()
                            })
                        }
                        .padding(.leading,-30)
                        .font(Font.custom("CourierPrime-Regular", size: 25))
                        
                        Text("or")
                            .padding([.top,.bottom], 10)
                            .font(Font.custom("CourierPrime-Regular", size: 17))
                        
                        
                        VStack {
                            GoogleSignInButton {
                                GoogleSignInHelper(sessionManager: sessionManager).SignInWithGoogle(from: getRootViewController())
                            }
                            
                            
                            
                                SignInWithAppleButton { request in
                                    appleSignIn.handleSignInWithAppleRequest(request)
                                } onCompletion: { result  in
                                    appleSignIn.handleSignInWithAppleCompletion(result)
                                }
                                
                                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                                .frame(width: 330, height: 50)
                                .cornerRadius(120)
                       
                                
                                
                                
                          

                        }
                        
                        Spacer()
                        
                    }
                    .padding()
                }
            }
        }
    }
    
   
}

