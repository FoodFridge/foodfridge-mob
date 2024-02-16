//
//  NavigationController.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/15/24.
//

import Foundation
import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var navigationPath: NavigationPath {
            didSet {
                print("Navigation Path Updated: \(navigationPath)")
            }
        }
        
    
    
    init(navigationPath: NavigationPath = NavigationPath()) {
          self.navigationPath = navigationPath
      }
    
    
}
