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
    @State private var items: [ListItem] = [
        ListItem(id: UUID(), text: "Item 1"),
        ListItem(id: UUID(), text: "Item 2"),
        ListItem(id: UUID(), text: "Item 3")
    ]
    @State private var text = ""
    @State private var editingItemId: Int?
    
    var body: some View {
        
        Text("Your pantry")
        Text("edit id : \(editingItemId ?? 100)")
        
        
        List($vm.pantryItems.indices, id: \.self) { index in
            
            
            
            if PantryItem.mockPantryItem[index].id == editingItemId    {
                HStack {
                    TextField((PantryItem.mockPantryItem[index].itemName), text: $text, onCommit: { self.editingItemId = nil
                    })
                    
                    
                    Button {
                        self.editingItemId = nil
                        //MARK:TODO:
                        //and save new data to database
                        
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
            
            
        }
        //.onDelete(perform: deleteItems)
        //.onMove(perform: moveItems)
        
    }
    
    
    
    
    
    func deleteItems(at offsets: IndexSet) {
        vm.pantryItems.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        vm.pantryItems.move(fromOffsets: source, toOffset: destination)
    }
    
    func editItem() {
        
    }
    
    
}

struct ListItem: Identifiable {
    let id: UUID
    var text: String
}

#Preview {
    PantryView()
}
