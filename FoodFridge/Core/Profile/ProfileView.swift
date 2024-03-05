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
                    HStack(spacing: 3) {
                        ForEach(ChoiceOfView.allCases, id: \.self) { view in
                            Button {
                                selectedView = view
                            } label: {
                                Text(view.rawValue)
                                    .font(Font.custom(CustomFont.appFontBold.rawValue, size: 20))
                                    .foregroundColor(view == selectedView ? .black : .gray)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(view == selectedView ? Color.button2 : Color.white)
                                    .cornerRadius(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.button1, lineWidth: 5)
                                        .opacity(view == selectedView ? 1 : 0)
                                        .offset(x: 0, y: 0)
                                    )
                            }

                        }
                    } 
                        
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
