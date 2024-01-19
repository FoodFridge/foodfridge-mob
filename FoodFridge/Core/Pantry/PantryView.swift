//
//  PantryView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import SwiftUI

struct PantryView: View {
    
    @EnvironmentObject var vm: ScanItemViewModel
  
    @FocusState private var isTextFieldFocused: Bool
    @State private var isEditing = false
 
    @State private var text = ""
    @State private var editingItemId: Int?
    
    var body: some View {
        
        Text("Your pantry")
        Text("(for testing) edit id : \(editingItemId ?? 1000)")
        
        
        List {
            Section(header: Text(Date(), style: .date)) {
                     ForEach($vm.pantryItems.indices, id: \.self) { index in
                         if PantryItem.mockPantryItem[index].id == editingItemId {
                             HStack {
                                 TextField(PantryItem.mockPantryItem[index].itemName, text: $text, onCommit: {
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
                         } else {
                             HStack {
                                 Text(PantryItem.mockPantryItem[index].itemName)
                                 Spacer()
                                 Button {
                                     isEditing = true
                                     self.editingItemId = PantryItem.mockPantryItem[index].id
                                 } label: {
                                     Text("Edit")
                                 }
                             }
                         }
                     }.onDelete(perform: deleteItems)
                 }
             }
    }
    
    

    func deleteItems(at offsets: IndexSet) {
        vm.pantryItems.remove(atOffsets: offsets)
    }
    
    
    
}

#Preview {
    PantryView()
}
