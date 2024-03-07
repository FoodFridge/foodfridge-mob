//
//  AddPantryView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 2/14/24.
//

import SwiftUI

struct AddPantryView: View {
    
    @StateObject private var vm = AddPantryViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        VStack(spacing: 1.2) {
            Spacer()
                ZStack{
                    HStack(spacing: 0) {
                        TextField("Enter item", text: $vm.searchText)
                            .padding()
                            .autocapitalization(.none)
                            //.background(Color.button4)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.button1, lineWidth: 5))
                        Spacer()
                        Button {
                            //MARK: TODO add pantry
                            if !vm.searchText.isEmpty {
                                vm.addPantry(sessionManager: sessionManager, item: vm.searchText)
                            }
                        } label: {
                            Text("Add")
                                .padding(.horizontal)
                                .frame(height: 62)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.button2, lineWidth: 5))
                            
                        }
                    }
                }
                
                   // Display suggestions
                List  {
                        ForEach(vm.suggestions, id: \.self) { suggestion in
                            Text(suggestion)
                                .onTapGesture {
                                    vm.searchText = suggestion // Update the text field with the selected suggestion
                                }
                        }
                        .listRowBackground(Color.button3)
                        .foregroundColor(.black)
                        
                        
                    }
                    .listStyle(PlainListStyle()) // Remove default List padding/styling
                  
            Spacer()
               }
               .scrollContentBackground(.hidden)
               .frame(maxWidth: .infinity)
               .padding()
       
    }
}

#Preview {
    AddPantryView()
}
