//
//  WebView.swift
//  IAteIt
//
//  Created by Eunbee Kang on 2023/09/06.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}
