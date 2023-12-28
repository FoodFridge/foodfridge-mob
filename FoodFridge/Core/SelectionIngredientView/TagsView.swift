//
//  TagsView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/27/23.
//

import SwiftUI
struct TagsView: View {
    
    let items : [String]
    var groupItems: [[String]] = [[String]]()
    let screenWidth = UIScreen.main.bounds.width
    
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
                
                let labelWidth = label.frame.size.width + 32
                if (width + labelWidth + 32) < screenWidth {
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
            LazyVStack {
                ForEach(groupItems, id:  \.self) { subItems in
                    HStack {
                        ForEach(subItems, id: \.self) { word in
                            Text(word)
                                .padding()
                                .padding(.vertical, -10)
                                .background((Color(.button3)))
                                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        }
                    }
                    
                }
            }
        }
    }
    
    
}


#Preview {
    TagsView(items: ["bread", "jasmine rice", "rice noodles", "egg noodles", "wholewheat bread", "spagetthi", "glass noodles", "potato", "corn", "pasta","quinou", "oatmeal", "pita", "tortilla", "corn bread", "taro", "sweet potato"])
}
