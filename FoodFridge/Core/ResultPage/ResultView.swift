//
//  ResultView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/25/24.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var vm: TagsViewModel
    @EnvironmentObject var sessionManager: SessionManager
  
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                Text("We've found Recipes!")
                    .padding(5)
                    .frame(width: 350, height: 45)
                    .background(.button2)
                    .cornerRadius(19)
                    .font(.custom(CustomFont.appFontBold.rawValue, size: 25))
                    .padding()
            }
            
            .padding()
            
            ScrollView {
                ForEach(0..<vm.generatedRecipes.count, id: \.self) { index in
                    NavigationLink(destination: LinkRecipesView(sessionManager: sessionManager, title: vm.generatedRecipes[index].title)) {
                        RecipeRow(title: vm.generatedRecipes[index].title , imageURL: vm.generatedRecipes[index].image)
                    }
                   
                    
                }
            }
            .scrollIndicators(.hidden)
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                if sessionManager.isLoggedIn() {
                    NavigationLink {
                        //MARK: navigate to Profile view
                        ProfileView()
                    }label: {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(Color(.button2))
                    }
                }
                
                NavigationLink {
                    //MARK: navigate to Scan Item view
                    ScanItemView()
                }label: {
                    Image(systemName: "camera.circle")
                        .foregroundColor(Color(.button2))
                }
            }
        }
        
       
    }
}

#Preview {
    ResultView()
}
