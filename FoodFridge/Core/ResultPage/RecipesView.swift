//
//  RecipesView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct RecipesView: View {
    var title: String = "Salmon with Ginger Glaze"
    var body: some View {
        
        Text("List of \(title) Recipes by google search")
        
    }
}

#Preview {
    RecipesView()
}
