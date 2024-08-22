//
//  WebView.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 3/16/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url : URL
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}

