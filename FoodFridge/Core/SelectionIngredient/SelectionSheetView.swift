//
//  selectionSheetView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/25/23.
//

import SwiftUI

struct SelectionSheetView: View {
    
    @State private var data : [String : [IngredientItem]] = [:]
    @State private var dataDict: [String : [String]] = ["" : [""]]
    @EnvironmentObject var vm: SelectionSheetViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        HStack {
        Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "x.circle.fill").resizable()
                
            })
            .frame(width: 20, height: 20)
            .padding(.top)
            .padding(.horizontal)
            .foregroundColor(Color(.button2))
        }
        
        
        NavigationStack {
            TagsView(dataDicts: vm.itemsDict )
           }
           .onAppear {
               //update all ingredients
               Task {
                   do {
                       
                       vm.fetchIngredients()
                       vm.itemsDict = vm.getItemsNameWithCategory(data: vm.ingredientsByType)
                       let fetchedData = try await GetIngredients().loadIngredients()
                       self.data = fetchedData
                       self.dataDict = vm.getItemsNameWithCategory(data: data)
                       vm.itemsDict = self.dataDict
                       
                   } catch {
                       print("Error fetching data: \(error.localizedDescription)")
                   }
               }
           }
      
      
    }
}


#Preview {
    SelectionSheetView()
}
