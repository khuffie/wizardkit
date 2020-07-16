//
//  WebView.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-06-03.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

public struct WebView: UIViewRepresentable {
	public  init(url: String) {
		self.url = url
	}
	
	
	public let url:String

    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
		
		return webView
    }

    public func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView>) {

        let request = URLRequest(url: URL(string: url)!)

        view.load(request)
    }
}
