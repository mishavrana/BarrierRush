import Foundation
import UIKit

class StartGameCoordinator: Coordinator {
    var rootViewController = UIViewController()
    
    func start() {
        let gameViewController = StartGameViewController()
        self.rootViewController = gameViewController
    }
}
