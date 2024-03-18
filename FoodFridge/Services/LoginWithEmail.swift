//
//  LoginWithEmail.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import Foundation
class LoginWithEmailService: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var logInError: LogInError?
    
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    
    func login(email:String, password: String) async throws  {
           
           guard let url = URL(string: AppConstant.logInWithEmailURLString2) else { throw URLError(.badURL)}
           
           do {
               // URL request object with URL and request method
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               
               //JSON data to be sent to the server
               let jsonData = try JSONSerialization.data(withJSONObject: ["email": email, "password": password], options: [])
               request.httpBody = jsonData
               
               //network request
               let (data, response) = try await URLSession.shared.data(for: request)
               
               guard let httpResponse = response as? HTTPURLResponse else {
                   throw LogInError.unknown
               }
               
               print("log in status code = \(httpResponse.statusCode)")
               
               switch httpResponse.statusCode {
                   
               case 200:
                   //if sign up successfully
                   //decode response data
                   let jsonResponse = try JSONDecoder().decode(LogInResponseData.self, from: data)
                   
                   // Print the JSON string for debugging
                   let jsonString = String(data: data, encoding: .utf8)
                   print("JSON String: \(jsonString ?? "N/A")")
                   
                   //save token in session
                   guard let token = jsonResponse.data.token else{
                       throw FetchError.serverError
                   }
                   self.sessionManager.saveAuthToken(token: token)
                   let savedLogIntoken = sessionManager.getAuthToken()
                   print("log in token = \(String(describing: savedLogIntoken))")
                   
                   //save id in session
                   guard let localID = jsonResponse.data.localId else{
                       throw FetchError.serverError
                   }
                   self.sessionManager.saveLocalID(id: localID)
                   let savedLogInlocalID = sessionManager.getLocalID()
                   print("log in token = \(String(describing: savedLogInlocalID))")
                   
                   //save refreshToken in session
                   guard let refreshToken = jsonResponse.data.refreshToken else{
                       throw FetchError.serverError
                   }
                   self.sessionManager.saveRefreshToken(token: refreshToken)
                   let savedRefreshToken = sessionManager.getRefreshToken()
                   print("refresh token = \(String(describing: savedRefreshToken))")
                   
                   
                   //save expTime in session
                    guard let expTime = jsonResponse.data.expTime else {
                    throw FetchError.serverError
                    }
                    self.sessionManager.saveExpTime(exp: expTime)
                    let savedExp = sessionManager.getExpTime()
                    print("exp time = \(String(describing: savedExp))")
                   
                   //update log in state to true
                   UserDefaults.standard.set(true, forKey: "userLoggedIn")
                   //if successfully
                   print("log in successfully")
                   return
                   
               case 401:
                   //if duplicate email
                   print("Incorrect credential")
                   //assign error to display
                   throw LogInError.inCorrectPassword
                   
               default:
                   print("Unknown error, please try again")
                   //assign error to display
                   throw LogInError.unknown
               }
        
               
           }
           catch {
               print("Log in Error: \(error.localizedDescription)")
               throw error
           }
            
      
        
       }
       
   }

enum LogInError : Error, LocalizedError {
    
    case inCorrectPassword
    case unknown 
    
    var errorDescription: String? {
        switch self {
        case .inCorrectPassword:
            return "Incorrect credential"
        case .unknown:
            return "An unknown error occurred. Please try again"
        }
    }
}
