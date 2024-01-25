//
//  ResultView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct ResultView: View {
    
    @State private var generatedRecipes: [String] = ["Salmon With Ginger Glaze", "Salmon Steak in Caramel Sauce (Vietnamese Ca Kho)","Ginger Soy Salmon – 5 Points","Teriyaki Salmon"]
    
    var body: some View {
        
        VStack {
            Text("We found 5 Recipes")
            ForEach(generatedRecipes, id: \.self) { recipeName in
                Text(recipeName)
            }
        }
       
    }
}

#Preview {
    ResultView()
}
