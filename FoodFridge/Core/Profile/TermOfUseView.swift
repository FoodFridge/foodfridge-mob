//
//  TermOfUseView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/19/24.
//

import SwiftUI

struct TermOfUseView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("FooodFridge Term of use").bold()
                        .padding(.vertical)
                    Text("jfdjfhljdfhjskjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsddjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsd")
                }
                .multilineTextAlignment(.leading)
            }
        }
        .padding()
       
        .onAppear {
            //load   json content form GH
        }
    }
}

#Preview {
    TermOfUseView()
}
