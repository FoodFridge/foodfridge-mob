//
//  AddPantryView2.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/13/24.
//

import SwiftUI

struct AddPantryView2: View {
    @StateObject private var vm = AddPantryViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var isTapped = false
    
    var body: some View {
      
            VStack(spacing: 1.2) {
                HStack {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("back")
                        })
                    }
                    .foregroundStyle(.accent)
                    Spacer()
                }
                .padding(.bottom, 40)
                
                Text("Add your pantry item")
                    .font(Font.custom(CustomFont.appFontBold.rawValue, size: 25))
                Spacer()
                ZStack{
                    HStack(spacing: 0) {
                        TextField("Enter item", text: $vm.searchText)
                            .padding()
                            .autocapitalization(.none)
                        //.background(Color.button4)
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
                                    //reset text after tap button
                                    vm.searchText = ""
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
                .listStyle(PlainListStyle()) // Remove default List padding/styling
                
                
                Spacer()
            }
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity)
            .padding()
            .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 17))
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .navigationBarBackButtonHidden(true)
            
            
        
         
               
               
       
    }
}

#Preview {
    AddPantryView2()
}
