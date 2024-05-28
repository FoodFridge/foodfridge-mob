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
    @State private var isSignedOut = false
    @State private var isShowAlert = false
    @State private var isTapped = false
    
    @EnvironmentObject var vm: TagsViewModel
    @EnvironmentObject var scrollTarget: ScrollTarget
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var navigationController: NavigationController
    
    @Environment(\.scenePhase) var scenePhase
    
   
    let rows = [GridItem(),GridItem(),GridItem(),GridItem(),GridItem(),GridItem()]

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
                                            
 
                                            ResultView(viewModel: ResultViewModel(ingredients: vm.selectedTags, sessionManager: sessionManager))
                                           
                                        }label: {
                                            SmallButton(title: "Generate Recipe", isTapped: $isTapped)
                                                
                                        }
                                        .disabled(vm.selectedTags.isEmpty)
                                        .frame(width: 200, height: 30)
                                        .offset(y: 85)
                                        .alert("", isPresented: $isShowAlert) {
                                            Button("ok", role: .cancel) { }
                                        } message: {
                                            Text("Please select ingredient")
                                        }
                                        .simultaneousGesture(TapGesture().onEnded({
                                            Task {
                                                if !vm.selectedTags.isEmpty {
                    
                                                } else {
                                                    isTapped = true
                                                    //resetState
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {  isTapped = false }
                                                   isShowAlert = true
                                               }
                                           }
                                        }))
                                    
                                
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
                                        SelectIngredientsButton(icon: category.icon, title: category.displayName, action: {
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
                            }else {
                                NavigationLink {
                                    //MARK: pop to Authen view
                                    AuthenticationView(appleSignIn: AppleSignInHelper(sessionManager: sessionManager))
                                }label: {
                                    Text("Sign in")
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
            .navigationBarBackButtonHidden(true)
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    //user come back to app
                    if let savedTags = UserDefaults.standard.array(forKey: "SavedTags") as? [String] {
                        print("landing user default comeback = \(savedTags) ")
                        // Use savedTags to display to user
                        vm.selectedTags = savedTags
                        print("forground loaded selectedtags = \(savedTags)")
                        print("forground vm selectedtags = \(vm.selectedTags)")
                        print("Restore - scencePhase")
                    }
                }
            }
            .onAppear {
                if let savedTags = UserDefaults.standard.array(forKey: "SavedTags") as? [String] {
                    print("on appear user default comeback = \(savedTags) ")
                    // Use savedTags to display to user
                    vm.selectedTags = savedTags
                    print("forground on appear loaded selectedtags = \(savedTags)")
                    print("forground on appear vm selectedtags = \(vm.selectedTags)")
                    
                }
            }
            
               
        }
        
}
