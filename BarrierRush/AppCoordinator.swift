import Foundation
import SwiftUI

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private var isAuthorized: Bool? = nil
    
    private var childCoordinator = [Coordinator]()
    
    init(window: UIWindow, isAuthorized: Bool?) {
        self.window = window
        self.isAuthorized = isAuthorized
    }
    
    func start() {
        self.window.makeKeyAndVisible()
        if let isAuthorized {
            if isAuthorized {
                let gameCoordinator = StartGameCoordinator()
                gameCoordinator.start()
                self.window.rootViewController = gameCoordinator.rootViewController
                self.childCoordinator.append(gameCoordinator)
            } else {
                let webViewCoordinator = WebViewCoordinator()
                webViewCoordinator.start()
                self.window.rootViewController = webViewCoordinator.rootViewController
                self.childCoordinator.append(webViewCoordinator)
            }
        } else {
           let loadingViewCoordinator = LoadingViewCoordinator()
            loadingViewCoordinator.start()
            self.window.rootViewController = loadingViewCoordinator.rootViewController
            self.childCoordinator.append(loadingViewCoordinator)
        }
    }
    
    func setIsAuthorized(_ value: Bool) {
        self.isAuthorized = value
    }
}
