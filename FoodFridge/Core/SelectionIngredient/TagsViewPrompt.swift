//
//  TagViewPrompt.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/28/23.
//

import SwiftUI

struct TagsViewPrompt: View {
   
    var groupItems: [[String]] = [[String]]()
    let screenWidth = UIScreen.main.bounds.width
    @State private var selectedItems = Set<String>()
    var items: [String]
    
    @EnvironmentObject var vm2: TagsViewModel
    
    init(items: [String]) {
        self.items = items
        groupItems = createGroupedItems(items: items)
        func createGroupedItems(items: [String]) -> [[String]] {
            var groupedItems: [[String]] = [[String]]()
            var tempItems: [String] = [String]()
            var width: CGFloat = 0
            for word in items {
                let label = UILabel()
                label.text = word
                label.sizeToFit()
                
                let labelWidth = label.frame.size.width + 40
                if (width + labelWidth + 40) < screenWidth {
                    width += labelWidth
                    tempItems.append(word)
                    
                }else {
                    width = labelWidth
                    groupedItems.append(tempItems)
                    tempItems.removeAll()
                    tempItems.append(word)
                }
                
            }
            groupedItems.append(tempItems)
            
            return groupedItems

        }
    }
    
    var body: some View {
        
        ScrollView {
            ScrollViewReader { scrollView in
                LazyVStack {
                    ForEach(groupItems, id:  \.self) { subItems in
                        HStack {
                            ForEach(subItems, id: \.self) { item in
                                Text("\(item) x")
                                    .font(Font.custom(CustomFont.appFontRegular.rawValue, size: 12))
                                    .foregroundStyle(.black)
                                    .lineLimit(1)
                                    .padding()
                                    .padding(.vertical, -10)
                                    .background((Color(.button4))
                                        .clipShape(RoundedRectangle(cornerRadius: 20.0)))
                                    .onTapGesture {
                                        vm2.deleteSelectedTag(tag: item)
                                        print("deleted : \(item)")
                                        print("update deleted list = \(vm2.selectedTags)")
                                        
                                        UserDefaults.standard.set(vm2.selectedTags, forKey: "SavedTags")
                                        if let loadedStringsArray = UserDefaults.standard.array(forKey: "SavedTags") as? [String] {
                                            // Use your loaded array
                                            print("save default selectedtags after delete = \(loadedStringsArray)")
                                        }
                                         
                                    }
                                    .onAppear {
                                        scrollView.scrollTo(item.last, anchor: .bottom)
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
        TagsViewPrompt(items: ["testing"])
}
