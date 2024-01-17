//
//  ProfileView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import SwiftUI

struct ProfileView: View {
    var data: IngredientData = IngredientData(data: IngredientItem.mockItems)
    var body: some View {
        VStack {
            Text("User Profile")
        }
        .onAppear {
            //fetch all ingredient
            Task {
                do {
                    // Assuming fetchData is an asynchronous function that returns data
                    let fetchedData = try await FetchIngredients().fetchIngedients()
                   
                    print("Successful retrieved data = \(fetchedData)")
                } catch {
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
