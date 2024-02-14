//
//  PantryView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/14/24.
//

import SwiftUI

struct PantryView: View {
    
    @EnvironmentObject var vm: ScanItemViewModel
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var isEditing = false
    @State private var isShowAddPantry = false
    
    @State var onSwipeId = ""
    @State private var text = ""
    @State private var editingItemId: String?
    
    var body: some View {
        
        
        Text("(for testing) edit id : \(editingItemId ?? "testId")")
        
        List {
            ForEach (vm.pantryItems, id: \.self) { pantryItem in
                
                Section(header: Text(pantryItem.date)) {
                    
                    ForEach(pantryItem.pantryInfo, id: \.self) { pantry in
                        
                        if pantry.id == editingItemId ?? "id" {
                            
                            HStack {
                                
                                TextField(pantry.pantryName, text: $text, onCommit: {
                                    self.editingItemId = nil
                                    // Handle the commit action here
                                })
                                
                                
                                Button {
                                    self.editingItemId = nil
                                    //MARK: TODO: Save new data to database
                                    
                                    
                                } label: {
                                    Text("Done")
                                }
                            }
                            //.listRowBackground(Color.button_1)
                            
                        } else {
                            HStack {
                                Text(pantry.pantryName)
                                Spacer()
                                Button {
                                    isEditing = true
                                    self.editingItemId = pantry.id
                                } label: {
                                    Text("Edit")
                                    
                                }
                            }
                            //   .listRowBackground(Color.button_1)
                        }
                    }
                    
                    .onDelete { offsets in
                        vm.deleteItem(at: offsets, from: pantryItem.date)
                    }
                    
                    .frame(minHeight: 50)
                    //.padding()
                    //.background(Color.button_1)
                    //.cornerRadius(10)
                    //.padding(.vertical, 4)
                }
            }
        }
        .onAppear {
            //fetch updated pantry
            vm.getPantry()
        }
        
        //MARK: TODO : Add new pantry
        Button {
            isShowAddPantry = true
        } label: {
            Image(systemName: "plus.app")
                .bold()
                .font(.title)
        }
        .sheet(isPresented: $isShowAddPantry) {
            AddPantryView()
        }
        
    }
    
    
}

#Preview {
    PantryView()
}
