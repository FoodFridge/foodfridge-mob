//
//  TagsView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/27/23.
//

import SwiftUI

struct TagsView: View {
    
    var dataDicts : [String : [String]]
    var groupItemsByType: [String : [[String]]] = [String : [[String]]]()
    let screenWidth = UIScreen.main.bounds.width
    var selectedTarget: String = ""
    
    
    @State private var selectedItems = Set<String>()
    @State private var searchTag = ""
    @State private var isLoadDone = true
    @State private var isSearchDone = true
    
    
    @State private var showAlertForLoginUser = false
    @State private var showAlertForNotLoginUser = false
    
    @State private var navigationSelection: NavigationSelection?
    // Use NavigationPath for path-based navigation
    @State private var navigationPath = NavigationPath()
    
    @EnvironmentObject var vm: TagsViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject var createGroup = CreateGroup()
    
    init(dataDicts: [String : [String]], selectedTarget: String) {
        
        self.dataDicts = dataDicts
        if !self.dataDicts.isEmpty {
            print("*******tagView got dataDict passed******** ")
        }else{
            print("tagView can't get passing dataDict")
        }
        
        groupItemsByType = createGroupedItemsWithType(items: dataDicts)
        self.selectedTarget = selectedTarget
        
        func createGroupedItemsWithType(items: [String: [String]]) -> [String: [[String]]] {
            var groupedItemsWithType: [String: [[String]]] = [:]
            for (key, words) in items {
                var width: CGFloat = 0
                var currentGroup: [String] = []
                
                for word in words {
                    let label = UILabel()
                    label.text = word
                    label.sizeToFit()
                    
                    let labelWidth = label.frame.size.width + 40 // Adjust padding as needed
                    if (width + labelWidth + 40) < screenWidth {
                        width += labelWidth
                        currentGroup.append(word)
                    } else {
                        if !currentGroup.isEmpty {
                            groupedItemsWithType[key, default: []].append(currentGroup)
                        }
                        width = labelWidth
                        currentGroup = [word]
                    }
                }
                
                // Append the last group if not empty
                if !currentGroup.isEmpty {
                    groupedItemsWithType[key, default: []].append(currentGroup)
                }
            }
            
            return groupedItemsWithType
        }
        
    }
    
    
    
    
    
    var sortedKeys: [String] {
        let keys = Array(groupItemsByType.keys)
        return keys.sorted { first, second in
            if first == selectedTarget {
                return true // Always place `selectedTargetKey` at the beginning
            } else if second == selectedTarget {
                return false // Never place `selectedTargetKey` at the beginning if it's the second element in comparison
            }
            return first < second // Sort the rest of the keys base on category(01-08)
        }
    }
    
    
    
    var body: some View {
       
            NavigationStack(path: $navigationPath) {
                ScrollView {
                    ScrollViewReader { scrollview in
                        
                        LazyVStack {
                            
                            if isLoadDone {
                                ForEach(sortedKeys, id: \.self) { key in
                                    if let category = Category(rawValue: key), category.displayName == "My Pantry" || groupItemsByType[key]?.contains(where: { subItems in
                                        searchTag.isEmpty || subItems.contains(where: { $0.lowercased().hasPrefix(searchTag.lowercased()) })
                                    }) == true  {
                                        
                                        if category.displayName == "My pantry" {
                                            HStack(spacing: 0){
                                                Text("My pantry")
                                                    .id(category.displayName)
                                                    .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 16))
                                                    .foregroundStyle(.button2)
                                                    .padding()
                                                    .padding(.vertical, -10)
                                                    .background(Color(.button1))
                                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                                
                                                
                                                Button(action: {
                                                    if UserDefaults.standard.bool(forKey: "userLoggedIn") {
                                                        showAlertForLoginUser = true
                                                    }else {
                                                        showAlertForNotLoginUser = true
                                                    }
                                                    
                                                }) {
                                                    Image(systemName: "plus.circle")
                                                        .font(.title)
                                                }
                                                .alert("", isPresented: $showAlertForNotLoginUser) {
                                                    Button("ok", role: .cancel) { }
                                                } message: {
                                                    Text("Please Sign in to add pantry")
                                                }
                                                
                                                
                                                .alert("Add Pantry", isPresented: $showAlertForLoginUser) {
                                                    Button("By camera", role: .destructive) {
                                                        // Update the navigation path to navigate
                                                        navigationPath.append(NavigationSelection.scanItemView)
                                                    }
                                                    Button("By text", role: .destructive) {
                                                        navigationPath.append(NavigationSelection.addPantryView)
                                                    }
                                                    Button("Not now", role: .cancel) { }
                                                } message: {
                                                    Text("How do you like to add the item?")
                                                }
                                                .navigationDestination(for: NavigationSelection.self) { destination in
                                                    switch destination {
                                                    case .scanItemView:
                                                        ScanItemView2(vm: ScanItemViewModel(sessionManager: sessionManager))
                                                    case .addPantryView:
                                                        AddPantryView2()
                                                    }
                                                }
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal)
                                            .foregroundStyle(.button2)
                                            
                                            
                                            
                                            
                                            
                                        }else {
                                            //Others Category name
                                            VStack {
                                                Text(category.displayName)
                                                    .id(category.displayName)
                                                    .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 16))
                                                    .foregroundStyle(.button2)
                                                    .padding()
                                                    .padding(.vertical, -10)
                                                    .background(category.displayName == "My pantry" ? Color(.button1) : Color(.button1))
                                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal)
                                        }
                                    }
                                    
                                    //ingredient tags
                                    // Filter and display tags based on the search text
                                    ForEach(groupItemsByType[key]?.filter { subItems in
                                        
                                        // Check if search text is empty or if any of the sub-items start with the search text (case-insensitive)
                                        return searchTag.isEmpty || subItems.contains(where: { $0.lowercased().hasPrefix(searchTag.lowercased()) })
                                    } ?? [], id: \.self) { subItems in
                                        
                                        HStack {
                                            ForEach(subItems, id: \.self) { tag in
                                                //MARK: TODO: check if pantry is empty?"
                                                if !tag.isEmpty {
                                                    Text(tag)
                                                        .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 14))
                                                        .lineLimit(1)
                                                        .padding()
                                                        .padding(.vertical, -10)
                                                        .background(selectedItems.contains(tag) ? (Color(.button4)) : (Color(.button3)) )
                                                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                                        .onTapGesture {
                                                            //update tag to prompt
                                                            vm.addSelectedTag(tag: tag)
                                                            print("selected tag = \(tag)")
                                                            print("update added list:\(vm.selectedTags)")
                                                            
                                                            //update tag background color in sheet
                                                            if selectedItems.contains(tag) {
                                                                selectedItems.remove(tag)
                                                                //update prompt list
                                                                vm.deleteSelectedTag(tag: tag)
                                                            }else {
                                                                selectedItems.insert(tag)
                                                            }
                                                        }
                                                }
                                                else{
                                                    Text(" ")
                                                        .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 10))
                                                }
                                                
                                            }
                                        }
                                        
                                    }
                                }
                                
                            };if isNoResultsFound() {
                                if isNoResultsFound() && isSearchDone {
                                    Text("No result found")
                                        .font(Font.custom(CustomFont.appFontBold.rawValue, size: 20))
                                        .padding()
                                        .foregroundColor(.gray)
                                }
                            }//else {
                               //ProgressView()
                            //}
                           
                             
                            
                        }
                        
                        
                    }
                    
                    
                }
                .searchable(text: $searchTag, placement:
                        .navigationBarDrawer(displayMode: .always))
            }
            
                    
    }
    
    // Function to determine if any search results are found
    private func isNoResultsFound() -> Bool {
        // Check if the searchTag is empty and return false immediately to avoid unnecessary computation
            guard !searchTag.isEmpty else { return false }
            // Iterate over each key-value pair in the dictionary
            for (_, arrayOfArrays) in groupItemsByType {
                // Iterate over each array in the array of arrays
                for array in arrayOfArrays {
                    // Check if any string in the array, when lowercased, contains the lowercased searchTag
                    if array.contains(where: { $0.lowercased().contains(searchTag.lowercased()) }) {
                        // If a match is found, return false immediately, indicating results are found
                        return false
                    }
                }
            }
            // If no matches are found in any of the nested arrays, return true
            return true
        }
}


/*
 #Preview {
     TagsView(dataDicts: ["" : [""]], selectedTarget: "", isTapped: .constant(true))
 }
 */
enum NavigationSelection: Hashable {
    case scanItemView
    case addPantryView
}


