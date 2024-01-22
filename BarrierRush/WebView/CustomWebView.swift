import Foundation
import WebKit
import SwiftUI

struct WebViewView: UIViewRepresentable {
    let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
