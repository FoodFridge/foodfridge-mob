//
//  ContentView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/20/23.
//

import SwiftUI
import AuthenticationServices


struct AuthenticationView: View {
   
    @State private var signUpWithEmailShow: Bool = false
    @State private var signUpWithGoogleShow: Bool = false
    @State private var signUpWithAppleShow: Bool = false
    @State private var landingPageShow: Bool = false
    @State private var logInPageShow: Bool = false
    
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var navigationController: NavigationController
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var appleSignIn: AppleSignInHelper
    
   
    var body: some View {
       
            NavigationStack  {
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
                                    
                                    LandingPageView()
                                    
                                } label: {
                                    
                                    Text("Skip")
                                    
                                }
                                .padding(.trailing, -10)
                                .offset(y: -130)
                                .foregroundStyle(Color(.button4))
                                
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
                                .padding([.top,.bottom], 1)
                                .font(Font.custom("CourierPrime-Regular", size: 17))
                            
                            //continue with gg and apple
                            VStack {
                                GoogleSignInButton {
                                    GoogleSignInHelper(sessionManager: sessionManager).SignInWithGoogle(from: getRootViewController())
                                }
                                
                                
                                switch colorScheme {
                                case .dark:
                                    SignInWithAppleButton { request in
                                        appleSignIn.handleSignInWithAppleRequest(request)
                                    } onCompletion: { result  in
                                        appleSignIn.handleSignInWithAppleCompletion(result)
                                    }
                                    .signInWithAppleButtonStyle(.white)
                                    .frame(width: 330, height: 50)
                                    .cornerRadius(120)
                                case .light:
                                    SignInWithAppleButton { request in
                                        appleSignIn.handleSignInWithAppleRequest(request)
                                    } onCompletion: { result  in
                                        appleSignIn.handleSignInWithAppleCompletion(result)
                                    }
                                    .signInWithAppleButtonStyle(.black)
                                    .frame(width: 330, height: 50)
                                    .cornerRadius(120)
                                @unknown default:
                                    SignInWithAppleButton { request in
                                        appleSignIn.handleSignInWithAppleRequest(request)
                                    } onCompletion: { result  in
                                        appleSignIn.handleSignInWithAppleCompletion(result)
                                    }
                                    .signInWithAppleButtonStyle(.whiteOutline)
                                    .frame(width: 330, height: 50)
                                    .cornerRadius(120)
                                }
                                
                                
                            }
                            
                            Spacer()
                            
                        }
                        .padding()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
           
        }
        
    
}


  
