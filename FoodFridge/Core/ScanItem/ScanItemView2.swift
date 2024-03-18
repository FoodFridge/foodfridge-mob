//
//  ScanItemView2.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/13/24.
//

import SwiftUI

struct ScanItemView2: View {
    @StateObject var vm: ScanItemViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var addButtonTapped = false
    //@State private var addedItem = ""
    @State private var isShowPantry = false
    
    var onDismiss: () -> Void
    
    var body: some View {
        VStack {
            DataScannerView(recognizedItems: $vm.recognizedItems, recognizedDataType: vm.recognizeDataType, recognizesMultipleItems: vm.recognizeMultipleItems)
                .background {
                    Color.gray.opacity(0.2)
                }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
                
            
            //implement added animation bar
            AddedBarAnimation(isTapped: addButtonTapped)
            
            VStack {
                VStack(alignment: .center) {
                    Text("Use camera to capture text on food package. Tap on green button to save.")
                }
                .font(Font.custom(CustomFont.appFontBold.rawValue, size: 15))
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .padding()
                            
                ScrollView {
                    LazyVStack {
                        ForEach(vm.recognizedItems) { item in
                            switch item {
                            case .text(let text):
                                Button {
                                    //add ingredient to user's pantry
                                    Task {
                                        try await AddPantry(sessionManager: sessionManager).addPantry(with: text.transcript.capitalized)
                                    }
                                   // vm.addItemToPantry(item: text.transcript.capitalized)
                                    
                                    // trigger animation bar
                                    addButtonTapped = true
                                    // Reset the state after a delay
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                    addButtonTapped = false
                                }
                                    
                                    
                                } label: {
                                    Text("Add: \(text.transcript)")
                                        .foregroundStyle(Color(.button2))
                                        .font(Font.custom(CustomFont.appFontBold.rawValue, size: 17))
                                        .padding()
                                        .background(Rectangle().foregroundStyle(.button1).cornerRadius(15))
                                }
                                .padding(.top)
                                
                                
                                
                            default:
                                Text("Unknown")
                            }
                        }
                    }
                }
                
               
                    VStack(alignment: .center) {
                        Button {
                            //dismiss view
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ) {
                            dismiss()
                        }
                        onDismiss()
                            
                        } label: {
                            Text("Go back")
                        }
                    }
                    .ignoresSafeArea()
                    .padding(.bottom, -50)
                    .foregroundStyle(Color(.accent))
                    .font(Font.custom(CustomFont.appFontBold.rawValue, size: 20))
                    
                   

               
              

            }
            .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
            .onChange(of: vm.recognizeMultipleItems) {  _ in
                vm.recognizedItems = []
                
            }
        }
        
    }
}

