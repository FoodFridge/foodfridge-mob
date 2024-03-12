//
//  selectionSheetView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/25/23.
//

import SwiftUI

struct SelectionSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scrollTarget: ScrollTarget
    @EnvironmentObject var vm: TagsViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
   
    var body: some View {
        VStack{
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
                    VStack {
                        TagsView(dataDicts: vm.itemsDict, selectedTarget: scrollTarget.targetID)
                    }
                }
           
        }
        .onAppear {
            Task {
                //update all ingredients
                try await vm.fetchIngredients()
                if !vm.ingredientsByType.isEmpty {
                    print("********sheetview got fetched ingredients data*********")
                }else {
                    print("sheetView can't get fethed data")
                }
                // transform fetched data to group of category
                vm.itemsDict = try await vm.getItemsNameWithCategory(data: vm.ingredientsByType)
                if !vm.itemsDict.isEmpty {
                    print("**********sheetView got transform fetched data to dataDict*********")
                }else {
                    print("sheetView can't get dataDict")
                }
                
            }
        }
        
    }
    
    
}


#Preview {
    SelectionSheetView()
}
