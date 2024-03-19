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
    @Environment(\.colorScheme) var colorScheme
    @State private var isTapped = false
    
    var body: some View {
        VStack(spacing: 1.2) {
            Text("Add your pantry item")
                .font(Font.custom(CustomFont.appFontBold.rawValue, size: 25))
            Spacer()
                ZStack{
                    HStack(spacing: 0) {
                        TextField("Enter item", text: $vm.searchText)
                            .padding()
                            .autocapitalization(.none)
                            .font(Font.custom(CustomFont.appFontBold.rawValue, size: 17))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.button1, lineWidth: 5))
                        Spacer()
                        Button {
                            //MARK: TODO add pantry
                            if !vm.searchText.isEmpty {
                                //add item
                                vm.addPantry(sessionManager: sessionManager, item: vm.searchText.trimmingCharacters(in: .whitespacesAndNewlines))
                                
                                //trigger button animation
                                isTapped = true
                                // Reset the state after a delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isTapped = false
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
                                        //reset text after tap button
                                        vm.searchText = ""
                                    }
                                }
                                
                                
                            }
                        } label: {
                            Text("Add")
                                .bold()
                                .padding(.horizontal)
                                .frame(height: 55)
                                .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.button2, lineWidth: 5)
                                    .scaleEffect(isTapped ? 1.2 : 1)
                                    .animation(.easeInOut, value: isTapped))
                            
                            
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
                .font(Font.custom(CustomFont.appFontBold.rawValue, size: 17))
                .listStyle(PlainListStyle()) // Remove default List padding/styling
         
            
            Spacer()
               }
               .scrollContentBackground(.hidden)
               .frame(maxWidth: .infinity)
               .padding()
               .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 17))
               
       
    }
}

#Preview {
    AddPantryView()
}
