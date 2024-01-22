//
//  LoadingViewCoordinator.swift
//  BarrierRush
//
//  Created by Misha Vrana on 22.01.2024.
//

import Foundation
import UIKit
import SwiftUI

class LoadingViewCoordinator: Coordinator {
   
    var rootViewController = UIViewController()
    
    
    func start() {
        let webViewController = UIHostingController(rootView: LoadingView())
        self.rootViewController = webViewController
    }
}
