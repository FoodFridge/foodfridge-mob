//
//  ExtentionView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/20/24.
//

import SwiftUI

extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
