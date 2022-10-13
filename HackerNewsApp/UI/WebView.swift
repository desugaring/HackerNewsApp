//
//  WebView.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-12.
//

import SwiftUI

import SwiftUI
import WebKit

/**
 
 Webview to display story and user webpages

 - has a strange iOS 16/Xcode 14 error pop up when calloing uiView.load - it is explained in detail below
 
 */
struct WebView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        
        // NOTE: calling load on main thread gives an error:
        // "This method should not be called on the main thread as it may lead to UI unresponsiveness."
        // however - it *has* to be called on the main thread.
        // This seems to be an iOS 16/XCode 14 problem, since it does not occur in iOS 15/Xcode 13
        // More info here:
        // https://developer.apple.com/forums/thread/713290
        
        uiView.load(request)
    }
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "http://google.com")!)
    }
}
