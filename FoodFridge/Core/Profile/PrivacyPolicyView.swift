//
//  PrivacyPolicyView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/19/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("FooodFridge Privacy policy").bold()
                        .padding(.vertical)
                    Text("jfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhaljfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhaljfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdjfdjfhljdfhjskfkdnfjskdafhlkfhlakhjrhlewuhfldiuhlfiusdhalifdlhsdifdlhsd")
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
    PrivacyPolicyView()
}
