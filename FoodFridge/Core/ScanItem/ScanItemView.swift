//
//  ScanItemView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import SwiftUI

struct ScanItemView: View {
    
    @EnvironmentObject var vm: ScanItemViewModel
    var userId = "test user"
    
    
    var body: some View {
        VStack {
            DataScannerView(recognizedItems: $vm.recognizedItems, recognizedDataType: vm.recognizeDataType, recognizesMultipleItems: vm.recognizeMultipleItems)
                .background {
                    Color.gray.opacity(0.2)
                }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
            
            VStack {
                VStack(alignment: .center) {
                    Text("Use camera to capture text on food package and save to your pantry")
                }
                .font(Font.custom(CustomFont.appFontBold.rawValue, size: 12))
                .padding()
    
                ScrollView {
                    LazyVStack {
                        ForEach(vm.recognizedItems) { item in
                            switch item {
                            case .text(let text):
                                Button {
                                    //add ingredient to user's pantry
                                    vm.addItemToPantry(item: text.transcript.capitalized, userId: self.userId)
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
                NavigationLink {
                    PantryView()
                } label: {
                    Text("Go to Pantry")
                        .font(Font.custom(CustomFont.appFontBold.rawValue, size: 17))
                }

            }//.onChange(of: vm.scanType) { _ in vm.recognizedItems = [] }
            .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
            .onChange(of: vm.recognizeMultipleItems) {  _ in
                vm.recognizedItems = []
                
            }
        }
    }
}

#Preview {
    ScanItemView()
}
