import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Configuring the Firebase
        FirebaseApp.configure()
        
        // Configuring window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Check for authorization
        let appCoordinator = AppCoordinator(window: window!, isAuthorized: nil)
        appCoordinator.start()
        
        Task {
            await NetworkCheck.shared.startCheckingConnection()
            let isAuthorized = await AuthService.shared.checkAuthorisation()
            appCoordinator.setIsAuthorized(isAuthorized)
            appCoordinator.start()
        }
        return true
    }
}

