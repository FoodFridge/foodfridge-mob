//
//  ChosenSubProfileView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/31/24.
//

import SwiftUI

struct ChosenSubProfileView: View {
    
    var selectedView: ChoiceOfView
    
    var body: some View {
        switch selectedView {
        case .pantry :
            PantryView()
        case .favorite:
            FavoriteRecipeView()
        }
    }
}

enum ChoiceOfView: String, CaseIterable {
    case pantry = "Pantry"
    case favorite = "Favorite Recipe"
}

#Preview {
    ChosenSubProfileView(selectedView: .favorite)
}
