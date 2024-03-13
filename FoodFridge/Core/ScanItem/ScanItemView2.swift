//
//  ScanItemView2.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/13/24.
//

import SwiftUI

struct ScanItemView2: View {
    @EnvironmentObject var vm: ScanItemViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
    var userId = "test user"
    @State private var addButtonTapped = false
    //@State private var addedItem = ""
    @State private var isShowPantry = false
    
    var body: some View {
        VStack {
            DataScannerView(recognizedItems: $vm.recognizedItems, recognizedDataType: vm.recognizeDataType, recognizesMultipleItems: vm.recognizeMultipleItems)
                .background {
                    Color.gray.opacity(0.2)
                }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
                .frame(height: 250)
            
            //implement added animation bar
            AddedBarAnimation(isTapped: addButtonTapped)
            
            VStack {
               
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
                                        .font(Font.custom(CustomFont.appFontBold.rawValue, size: 17))
                                        .padding()
                                        .background(Rectangle().foregroundStyle(.button1).cornerRadius(15))
                                }
                                .padding(.top, 30)
                                
                                
                                
                            default:
                                Text("Unknown")
                            }
                        }
                    }
                }
                
               
    
              

            }
            .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
            .onChange(of: vm.recognizeMultipleItems) {  _ in
                vm.recognizedItems = []
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ScanItemView2()
}
