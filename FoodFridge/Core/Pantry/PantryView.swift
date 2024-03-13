//
//  PantryView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/14/24.
//

import SwiftUI
import Foundation

struct PantryView: View {
    
    @EnvironmentObject var vm: ScanItemViewModel
    
    @FocusState private var isTextFieldFocused: Bool

    @State var onSwipeId = ""
   
    @State private var editingItemId: String?
    
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            
            if !vm.pantryItems.isEmpty {
                //let userTimeZone = TimeZone.current
                //Text("(for testing) edit id : \(editingItemId ?? "testId")")
                //Text("user time zone identifier = \(userTimeZone.identifier)")
                
                List {
                    ForEach(vm.pantryItems.indices, id: \.self) { pantryIndex in
                        Section(header: Text(vm.pantryItems[pantryIndex].date)) {
                            ForEach(vm.pantryItems[pantryIndex].pantryInfo.indices, id: \.self) { pantryItemIndex in
                                let pantry = $vm.pantryItems[pantryIndex].pantryInfo[pantryItemIndex]
                                if pantry.id == editingItemId {
                                    HStack {
                                        TextField("Enter pantry name" , text: $vm.pantryItems[pantryIndex].pantryInfo[pantryItemIndex].pantryName)
                                        Button(action: {
                                            //if user edit some text
                                                // Save new data to database
                                            if !String(vm.pantryItems[pantryIndex].pantryInfo[pantryItemIndex].pantryName).isEmpty {
                                                Task {
                                                    try await EditPantry.edit(itemID: editingItemId ?? "", to:   String(vm.pantryItems[pantryIndex].pantryInfo[pantryItemIndex].pantryName).trimmingCharacters(in: .whitespacesAndNewlines))
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Delay of 0.2 second
                                                        withAnimation {
                                                            self.editingItemId = nil
                                                        }
                                                    }
                                                }
                                            }else {
                                                //show alert
                                                self.showAlert = true
                                            }
                                            
                                        }) {
                                            Text("Done")
                                        }
                                        .alert(isPresented: $showAlert) {
                                            Alert(title: Text(""), message: Text("Please enter item to save"), dismissButton: .default(Text("OK")))
                                                }
                                    }
                                    .focused($isTextFieldFocused) // Bind to FocusState
                                    .onAppear {
                                    DispatchQueue.main.async {
                                    self.isTextFieldFocused = true // Activate editing mode
                                }
                                }
                                    
                                } else {
                                    HStack {
                                        Text(vm.pantryItems[pantryIndex].pantryInfo[pantryItemIndex].pantryName)
                                        Spacer()
                                        Button(action: {
                                            self.editingItemId = pantry.id
                                        }) {
                                            Text("Edit")
                                        }
                                    }
                                }
                            }
                            .onDelete { offsets in
                                vm.deleteItem(at: offsets, from: vm.pantryItems[pantryIndex].date)
                                
                            }
                            .frame(minHeight: 50)
                        }
                    }
                }
                
    
                 
            }
            else if vm.isLoading {
                ProgressView()
            }
            else {
                Text("Your pantry is empty")
            }
        }
        .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 17))
        .onAppear {
            
            //fetch updated pantry
            Task {
                await vm.getPantry()
            }
        }
        
        
        //MARK: TODO : Add new pantry
        NavigationLink {
            AddPantryView()
        } label: {
            Image(systemName: "plus.app")
                .bold()
                .font(.title)
        }
        
        
    }
    
}

#Preview {
    PantryView()
}
