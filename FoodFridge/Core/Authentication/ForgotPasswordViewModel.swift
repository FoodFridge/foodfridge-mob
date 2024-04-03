//
//  ForgotPasswordViewModel.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 4/2/24.
//

import Foundation

@MainActor
class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var resetPasswordFeedback: Int = 0
    
    func resetPassword(email : String) async throws -> Int {
        self.resetPasswordFeedback = try await ResetPassword.requestResetEmail(email: email)
        return self.resetPasswordFeedback
    }
}
