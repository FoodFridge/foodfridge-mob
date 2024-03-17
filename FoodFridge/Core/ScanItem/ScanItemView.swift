//
//  ScanItemView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import SwiftUI

struct ScanItemView: View {
    
    @EnvironmentObject var vm: ScanItemViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
    var userId = "test user"
    @State private var addButtonTapped = false
    //@State private var addedItem = ""
    @State private var isShowPantry = false
    @Environment(\.dismiss) var dismiss
    
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
                                        .font(Font.custom(CustomFont.appFontBold.rawValue, size: 17))
                                        .padding()
                                        .background(Rectangle().foregroundStyle(.button1).cornerRadius(15))
                                        .foregroundStyle(.button2)
                                }
                                .padding(.top, 30)
                                
                                
                                
                            default:
                                Text("Unknown")
                            }
                        }
                    }
                }
                
                
                VStack(alignment: .center) {
                    Button {
                        //dismiss view
                        dismiss()
                    } label: {
                        Text("Go back")
                    }
                }
                .ignoresSafeArea()
                .padding(.bottom, -50)
                .foregroundStyle(Color(.accent))
                .font(Font.custom(CustomFont.appFontBold.rawValue, size: 20))
               /*
                    //MARK: Display Pantry button
                    Button {
                        isShowPantry = true
                    } label: {
                        Text("Go to Pantry")
                            .font(Font.custom(CustomFont.appFontBold.rawValue, size: 17))
                    }
                    .disabled(!sessionManager.isLoggedIn())
                    .sheet(isPresented:
                            $isShowPantry) {
                        PantryView2()
                    }
            */
              

            }
            .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
            .onChange(of: vm.recognizeMultipleItems) {  _ in
                vm.recognizedItems = []
                
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ScanItemView()
}
