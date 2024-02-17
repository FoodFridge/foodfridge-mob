//
//  Authentication.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/16/24.
//

import Foundation
import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    func updateValidation(success: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Delay of 0.2 second
               withAnimation {
                   self.isValidated = success
               }
           }
    }
}
