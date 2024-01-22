//
//  WebViewCoordinator.swift
//  BarrierRush
//
//  Created by Misha Vrana on 19.01.2024.
//
import Foundation
import SwiftUI
import UIKit
import WebKit

class WebViewCoordinator: Coordinator {
   
    var rootViewController = UIViewController()
    
    
    func start() {
        let webViewController = UIHostingController(rootView: WebView())
        self.rootViewController = webViewController
    }
}
