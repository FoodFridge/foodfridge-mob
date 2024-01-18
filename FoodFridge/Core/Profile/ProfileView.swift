//
//  ProfileView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var data : [String: [IngredientItem]] = [:]
    var body: some View {
        VStack {
            Text("\(data.count)")
            
        }
        .onAppear {
            //fetch all ingredient
            Task {
                do {
                    // Assuming fetchData is an asynchronous function that returns data
                    let fetchedData =  try FetchIngredientsLocal().loadIngredients()
                    self.data = fetchedData
                    //print("Successful retrieved data = \(fetchedData)")
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
