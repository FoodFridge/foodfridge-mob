//
//  ProfileView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var data: [String: [IngredientItem]] = [:]
    @State private var dictData: [String : [String]] = [:]
    var body: some View {
        VStack {
            Text("\(data.count)")
            Text("\(dictData.count)")
            List(dictData.keys.sorted(), id: \.self) { key in
                        Section(header: Text("Type Code: \(key)")) {
                            ForEach(dictData[key] ?? [], id: \.self) { ingredientName in
                                Text(ingredientName)
                                
                            }
                            
                            }
                        }
            
        }
        .onAppear {
            //fetch all ingredient
            Task {
                do {
                    // Assuming fetchData is an asynchronous function that returns data
                    let fetchedData =  try FetchIngredientsLocal().loadIngredients()
                    self.data = fetchedData
                    //print("Successful retrieved data = \(fetchedData)")
                    self.dictData = SelectionSheetViewModel().getItemsNameWithCategory(data: self.data)
                    
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
