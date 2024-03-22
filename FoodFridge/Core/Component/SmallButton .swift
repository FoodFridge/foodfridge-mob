//
//  SmallButton .swift
//  FoodFridge
//
//  Created by Jessie Pastan on 12/25/23.
//

import SwiftUI


struct SmallButton: View {
   
    var title = "Title"
    @Binding var isTapped: Bool
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.button1, lineWidth: 3)
                .background(Color(.button2).cornerRadius(10))
                .scaleEffect(isTapped ? 1.2 : 1 )
                .animation(.easeInOut, value: isTapped)
            
            
            Text(title)
                .font(Font.custom("CourierPrime-Regular", size: 17))
                .foregroundStyle(Color.black)
                .bold()
        
        }
       
        

    }
}
#Preview {
    SmallButton(isTapped: .constant(true))
}
