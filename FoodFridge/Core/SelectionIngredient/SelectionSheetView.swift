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
    //@State var searchTag = ""
    
    @ObservedObject var vm = SelectionSheetViewModel()
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
            TagsView(dataDicts: self.dataDict )
           }
           .onAppear {
               //fetch all ingredient
               Task {
                   do {
                       
                       let fetchedData =  try await GetIngredients().loadIngredients()
                       self.data = fetchedData
                       self.dataDict = vm.getItemsNameWithCategory(data: self.data)
                       
                       //print("Successful retrieved data = \(fetchedData)")
                       
                       
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
