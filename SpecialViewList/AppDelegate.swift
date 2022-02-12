import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let controller = SpecialViewListViewController()
        let navController = UINavigationController()
        navController.viewControllers = [controller]
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        return true
    }
}
