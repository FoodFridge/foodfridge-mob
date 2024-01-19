//
//  ScanItemView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import SwiftUI

struct ScanItemView: View {
    
    @EnvironmentObject var vm: ScanItemViewModel
    
    
    
    var body: some View {
        VStack {
            DataScannerView(recognizedItems: $vm.recognizedItems, recognizedDataType: vm.recognizeDataType, recognizesMultipleItems: vm.recognizeMultipleItems)
                .background {
                    Color.gray.opacity(0.2)
                }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
            
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.recognizedItems) { item in
                            switch item {
                            case .text(let text):
                                Button {
                                    //add ingredient to user's fridge
                                    vm.addItemToPantry(item: text.transcript)
                                } label: {
                                    Text("Add: \(text.transcript)\n to your fridge")
                                        .padding()
                                        .background(Rectangle().foregroundStyle(.button1).cornerRadius(15))
                                }
                                .frame(width: 200)
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
