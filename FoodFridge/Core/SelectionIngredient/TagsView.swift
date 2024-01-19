//
//  TagsView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/27/23.
//

import SwiftUI
struct TagsView: View {
    
    let dataDicts : [String : [String]]
    var groupItemsByType: [String : [[String]]] = ["" : [[""]]]
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var selectedItems = Set<String>()
    @EnvironmentObject var vm: TagsViewModel
    
    init(dataDicts: [ String : [String]]) {
        
        self.dataDicts = dataDicts
        groupItemsByType = createGroupedItemsWithType(items: dataDicts)
        
        func createGroupedItemsWithType(items: [String: [String]]) -> [String: [[String]]] {
            var groupedItemsWithType: [String: [[String]]] = [:]
            for (key, words) in items {
                var width: CGFloat = 0
                var currentGroup: [String] = []
                
                for word in words {
                    let label = UILabel()
                    label.text = word
                    label.sizeToFit()
                    
                    let labelWidth = label.frame.size.width + 32 // Adjust padding as needed
                    if (width + labelWidth + 32) < screenWidth {
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
            
    
    var body: some View {
        ScrollView {
            LazyVStack {
    
                    ForEach(Array(groupItemsByType.keys.sorted()), id: \.self) { key in
                        if let category = Category(rawValue: key) {
                           
                            //Category name
                            VStack {
                                Text(category.displayName)
                                    .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 15))
                                    .foregroundStyle(.button2)
                                    .padding()
                                    .padding(.vertical, -10)
                                    .background(Color(.button1))
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        }
                    
                    //tags 
                    ForEach(groupItemsByType[key] ?? [], id: \.self) { subItems in
                        
                            HStack {
                                ForEach(subItems, id: \.self) { tag in
                                    Text(tag)
                                        .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 12))
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
                            }
                    }
                }
            }
            
        }
             
    }
}

/*
 #Preview {
 TagsView(items: ["bread", "jasmine rice", "rice noodles", "egg noodles", "wholewheat bread", "spagetthi", "glass noodles", "potato", "corn", "pasta","quinou", "oatmeal", "pita", "tortilla", "corn bread", "taro", "sweet potato"], dataItems: ["01" : IngredientItem.mockItems], dataDicts: ["" : [""]])
 }
 */
