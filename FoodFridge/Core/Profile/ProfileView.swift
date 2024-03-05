//
//  ProfileView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/9/24.
//

import SwiftUI

struct ProfileView: View {
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .button2
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
    }
   
    
    @State private var selectedView: ChoiceOfView = .favorite
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Picker("", selection: $selectedView) {
                    ForEach(ChoiceOfView.allCases, id: \.self) {
                        Text($0.rawValue)
                            
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .foregroundStyle(.button4 )
               
               
                
                Spacer()
                ChosenSubProfileView(selectedView: selectedView)
                Spacer()
                
                
            }
            
            
        }
        .toolbar {
            
            NavigationLink {
                //MARK: navigate to Profile view
                ProfileSettingView()
            }label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(Color(.button2))
            }
        }
    }
}





#Preview {
    ProfileView()
}
