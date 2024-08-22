//
//  NavigationController.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/20/24.
//

import Foundation
class NavigationController: ObservableObject {
    @Published var currentView: CurrentView = .onboarding

    enum CurrentView {
        case onboarding
        case authentication
        case landingPage
    }
}
