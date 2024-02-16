//
//  FoodFridgeApp.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/20/23.
//

import SwiftUI

@main
struct FoodFridgeApp: App {
    @StateObject var authentication = Authentication()
    
    var body: some Scene {
        
        WindowGroup {
            
            if authentication.isValidated {
                LandingPageView()
                    .environmentObject(authentication)
                    .environmentObject(TagsViewModel())
                    .environmentObject(ScanItemViewModel())
                    .environmentObject(SelectionSheetViewModel())
                    .environmentObject(ScrollTarget())
                
            } else {
                AuthenthicationView()
                    .environmentObject(authentication)
                    .environmentObject(TagsViewModel())
                    .environmentObject(ScanItemViewModel())
                    .environmentObject(SelectionSheetViewModel())
                    .environmentObject(ScrollTarget())
            }
        }
    }
}
