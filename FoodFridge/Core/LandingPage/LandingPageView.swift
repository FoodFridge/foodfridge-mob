//
//  LandingPageView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/21/23.
//

import SwiftUI

struct LandingPageView: View {
    
    @State private var showSheet = false
    @State var selectedTags = Set<String>()
    @State var selectedItems = [String]()
    @State private var referenceHeight: CGFloat = 0

    @EnvironmentObject var vm: TagsViewModel
    @EnvironmentObject var scrollTarget: ScrollTarget
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var sessionManager: SessionManager
  
    let rows = [GridItem(),GridItem(),GridItem(),GridItem(),GridItem(),GridItem()]
    
    
    @State private var isSignedOut = false
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    //MARK: Head line
                    VStack(alignment: .leading) {
                        Text("Let’s cook something from your fridge!")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(Font.custom("CourierPrime-Bold", size: proxy.size.height / 25 ))
                        Text("Select items from categories below")
                            .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 15))
                    }
                    
                    //MARK: Prompt
                    ZStack {
                        let prompt = Rectangle()
                        prompt.frame( height: proxy.size.height / 3.5).cornerRadius(10)
                            .onAppear {
                                referenceHeight = proxy.size.height / 3.5
                            }
                            //MARK: Display Selected ingredients in prompt
                            .overlay (
                                TagsViewPrompt(items: vm.selectedTags)
                                    .padding(.top, 3)
                                    .frame(height: referenceHeight * 0.7)
                                , alignment: .topLeading
                                    
                            )
                            //MARK: Genenerate Recipes Button
                            .overlay(
                                
                                NavigationLink {
                                    //TODO: tap and link to result of generated recipe
                                    ResultView()
                                } label: {
                                    SmallButton(title: "Generate Recipe")
                                }
                                .simultaneousGesture(TapGesture().onEnded({
                                    Task {
                                        try await vm.generateRecipe(from: vm.selectedTags)
                                    }
                                 }))
                                .frame(width: 200, height: 30)
                                .offset(y: 85)
                            )
                    }
                    .padding(.top, -10)
                    
                    //MARK: Picture
                    Image("chef")
                        .resizable()
                        .frame(width: proxy.size.width / 2 , height: proxy.size.width / 2)
                    Spacer()
                    //MARK: Select ingredients buttons
                    ScrollView {
                        LazyHGrid (rows: rows) {
                            ForEach(Category.allCases, id: \.self) { category in
                                VStack {
                                    SelectIngredientsButton(title: category.displayName, action: {
                                        print("**Button \(category.displayName)*** tapped!")
                                            showSheet = true
                                            //assign key to display selectedCategory
                                            scrollTarget.targetID = category.rawValue
                                       
                                    }, sheetHeight: proxy.size.height,width: proxy.size.width / 2.5, height: proxy.size.height / 15, showSheet: $showSheet)
                                }
                            }
                        }
                    }
                    .padding(.bottom, -25)
                    
                    Spacer()
                    
                }
                
                .padding(4)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                     
                        if  UserDefaults.standard.bool(forKey: "userLoggedIn") || sessionManager.isLoggedIn() {
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
    }
}

